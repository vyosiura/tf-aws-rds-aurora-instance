locals {
  pg_format = (
    var.engine == "aurora-postgresql" && join("", slice(split(".", var.engine_version), 0, 1)) == "9" ? 
      join("", slice(split(".", var.engine_version), 0, 1)) : 
      join("-", slice(split(".", var.engine_version), 0, 2))
  )
}


resource "aws_db_parameter_group" "aurora" {
  count                                         = var.db_parameter_group_name == null ? 0 : 1
  name                                          = lower("${var.db_parameter_group_name}-${var.instance_scope}-pg")
  description                                   = "Parameter group for ${var.cluster_identifier}-${var.instance_scope}" 
  family                                        = var.parameter_group_family
  dynamic "parameter" {
    for_each  = var.parameters
    content {
      name          = parameter.value["name"]
      value         = parameter.value["value"]
      apply_method  = lookup(parameter.value, "apply_method", "immediate")
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}


resource "random_id" "instance" {
  count                                         = var.instance_count
  byte_length                                   = 3
}


resource "aws_rds_cluster_instance" "aurora" {
    count                                       = var.instance_count
    
    identifier                                  = lower("${var.cluster_identifier}-${var.instance_scope}-${random_id.instance[count.index].hex}")
    cluster_identifier                          = var.cluster_identifier
    engine                                      = var.engine
    engine_version                              = var.engine_version
    instance_class                              = var.instance_class
    publicly_accessible                         = var.publicly_accessible
    db_subnet_group_name                        = var.db_subnet_group_name
    db_parameter_group_name                     = var.db_parameter_group_name == null ? null : aws_db_parameter_group.aurora[0].name
    apply_immediately                           = var.apply_immediately
    monitoring_role_arn                         = var.monitoring_interval > 0 ? var.monitoring_role_arn : null
    monitoring_interval                         = var.monitoring_interval
    promotion_tier                              = var.promotion_tier
    availability_zone                           = var.availability_zone
    preferred_backup_window                     = var.preferred_backup_window
    preferred_maintenance_window                = var.preferred_maintenance_window
    auto_minor_version_upgrade                  = var.auto_minor_version_upgrade
    performance_insights_enabled                = join("", slice(split(".", var.instance_class), 1, 1)) == "t3" ? false : var.performance_insights_enabled
    performance_insights_kms_key_id             = var.performance_insights_kms_key_id
    copy_tags_to_snapshot                       = var.copy_tags_to_snapshot
    ca_cert_identifier                          = var.ca_cert_identifier
    tags                                        = var.tags
    lifecycle {
      ignore_changes = [
        engine_version
      ]
    }
}


resource "aws_rds_cluster_endpoint" "aurora" {
  cluster_identifier            = var.cluster_identifier
  cluster_endpoint_identifier   = lower("${var.cluster_identifier}-${var.instance_scope}-ro")
  custom_endpoint_type          = "READER"
  static_members                = aws_rds_cluster_instance.aurora.*.id
  depends_on = [
    aws_rds_cluster_instance.aurora
  ]
}


resource "aws_route53_record" "aurora" {
  count                                     = var.zone_id == null ? 0 :1
  zone_id                                   = var.zone_id 
  name                                      = lower("db-${var.cluster_identifier}-${var.instance_scope}-ro")
  type                                      = "CNAME"
  ttl                                       = var.record_ttl
  records                                   = [ aws_rds_cluster_endpoint.aurora.endpoint ]
  depends_on = [
    aws_rds_cluster_endpoint.aurora
  ]
}