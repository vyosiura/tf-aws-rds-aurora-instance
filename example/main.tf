module "aws_rds_cluster" {
    source                      = "git@github.com-personal:vyosiura/tf-aws-rds-cluster.git"
    master_username             = "root"
    master_password             = "213asdd231"
    vpc_id                      = var.vpc_id
    db_subnet_group_name        = var.db_subnet_group_name
    cluster_identifier          = var.cluster_identifier
    backtrack_window            = 0
    engine                      = var.engine
    engine_version              = var.engine_version
    apply_immediately           = true
    parameter_group_family      = var.parameter_group_family
    deletion_protection         = false
}


module "aws_rds_instance" {
    source                      = "../"
    engine                      = var.engine
    engine_version              = var.engine_version
    cluster_identifier          = module.aws_rds_cluster.cluster_identifier
    parameter_group_family      = var.parameter_group_family
    db_subnet_group_name        = var.db_subnet_group_name
    monitoring_role_arn         = var.monitoring_role_arn
    db_parameter_group_name     = "${var.cluster_identifier}-test"
    apply_immediately           = true
    parameters                  = [
        {
            name            = "max_user_connections"
            value           = "100"
            apply_method    = "immediate"
        }
    ]
}



