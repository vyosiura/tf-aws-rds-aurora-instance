# variable "record_name" {
#   description = "Registro de DNS que será criado"
#   type        = string
#   default     = null
# }

# variable "record_type" {
#   description = "Tipo do registro que será criado."
#   type        = string
#   default     = "CNAME"
# }

# variable "zone_id" {
#   description = "Id da zona do Route53 que serão criados o registro DNS do cluster endpoint se este argumento for preenchido. Default do nome do registro será: cluster-identifier-instance-scope-ro"
#   type        = string
#   default     = null
# }

# variable "record_ttl" {
#   description = "TTL do registro DNS"
#   type        = number
#   default     = 300
# }

variable "parameters" {
  description = "Lista de maps com os valores dos parametros do parameter group que devem ser criados"
  type        = list(object({
    name          = string
    value         = string
    apply_method  = string
  }))
  default     = []
}

variable "cluster_identifier" {
  description = "Nome do cluster que a instância pertence"
  type        = string
  validation {
    condition     = var.cluster_identifier != null && var.cluster_identifier != ""
    error_message = "Please specify the required variable cluster_identifier."
  }
}

variable "engine" {
  description = "Engine utilizada pelo Aurora. Possíveis valores: `aurora`, `aurora-mysql` e `aurora-postgresql`"
  type        = string
  validation {
    condition     = var.engine != null && (var.engine == "aurora-mysql" || var.engine == "aurora" || var.engine == "aurora-postgresql")
    error_message = "Please specify the database engine (engine). Possible values: `aurora`, `aurora-postgresql`, `aurora-mysql`."
  }
}

variable "engine_version" {
  description = "Versão da engine utilizada"
  type        = string
  validation {
    condition     = var.engine_version != null
    error_message = "Please specify the database engine version (engine_version)."
  }
}

variable "instance_class" {
  description = "Tamanho e família da instância"
  type        = string
  default     = "db.r4.large"
}

variable "publicly_accessible" {
  description = "Se a instância pode ser acessada publicamente. MEXER COM CUIDADO"
  type        = bool
  default     = false
}

variable "db_subnet_group_name" {
  description = "Nome do subnetgroup que será atribuido à instância"
  type        = string
}

variable "db_parameter_group_name" {
  description = "Nome do parameter group que será criado caso `create_parameter_group`  seja `true` para a instância. Senão, tentará usar um parameter group com esse nome"
  type        = string
}

variable "parameter_group_family" {
  description = "Family do parameter group. Utilizar o data source `aws_rds_engine_version` para ter uma precisão melhor."
  type        = string
  validation {
    condition       = var.parameter_group_family != null
    error_message   = "Please specify the parameter group family (paramter_group_family)."
  } 
}

variable "apply_immediately" {
  description = "Aplica as alterações na hora que são submetidas caso `true`, senão ira aplicar apenas na janela de manutenção definida"
  type        = bool
  default     = true
}

variable "monitoring_role_arn" {
  description = "ARN da role de monitoramento para habilitar o enhanced metrics"
  type        = string
  default     = null
}

variable "monitoring_interval" {
  description = "Intervalo de tempo da coleta de métricas pelas enhanced monitoring"
  type        = number
  default     = 60
}

variable "promotion_tier" {
  description = "Tier da instância para failover. Quanto menor o tier, maior a chance da instância ser escolhida como primária"
  type        = number
  default     = 0
}

variable "availability_zone" {
  description = "Zona de disponibilidade que a instância será criada"
  type        = string
  default     = null
}

variable "preferred_backup_window" {
  description = "Janela de backup. Determinar hora em UTC. Ex.: `04:00-06:00` LEMBRANDO QUE É UTC!!!"
  type        = string
#   default     = "04:00-05:00"
  default     = null
}

variable "preferred_maintenance_window" {
  description = "Janela de manutenção. Determinar data e hora em UTC. Ex.: `MON:04:00-MON:06:00` LEMBRANDO QUE É UTC!!!"
  type        = string
  default     = null 
}

variable "auto_minor_version_upgrade" {
  description = "Habilita aplicação de patchs automaticamente"
  type        = bool
  default     = true
}

variable "performance_insights_enabled" {
  description = "Habilita o performance insights"
  type        = bool
  default     = true
}

variable "performance_insights_kms_key_id" {
  description = "Chave KMS para ser utilizada para criptografia dos dados do Performance Insights"
  type        = string
  default     = null
}

variable "copy_tags_to_snapshot" {
  description = "Passa as tags dessa instância para seus respectivos snapshots"
  type        = bool
  default     = false
}

variable "ca_cert_identifier" {
  description = "Identificardor da CA utilizado pelo RDS"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags para atribuir à instância"
  type        = map(string)
  default     = null
}

variable "instance_count" {
  description = "Quantidade de instâncias. Quais instâncias que serão criadas"
  type        = number
  default     = 1 
}

# variable "instance_scope" {
#   description = "Especificar o propósito das instâncias. Exemplos: `app`, `cdc`, `extraction`, etc..."
#   type        = string
#   default     = null
#   validation {
#     condition     = var.instance_scope != null
#     error_message = "Please specify the scope of the instances (instance_scope)."   
#   } 
# }