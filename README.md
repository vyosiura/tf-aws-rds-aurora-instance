## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.41 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.41 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_parameter_group.aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_rds_cluster_endpoint.aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_endpoint) | resource |
| [aws_rds_cluster_instance.aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_route53_record.aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [random_id.instance](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Aplica as alterações na hora que são submetidas caso `true`, senão ira aplicar apenas na janela de manutenção definida | `bool` | `true` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Habilita aplicação de patchs automaticamente | `bool` | `true` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Zona de disponibilidade que a instância será criada | `string` | `null` | no |
| <a name="input_ca_cert_identifier"></a> [ca\_cert\_identifier](#input\_ca\_cert\_identifier) | Identificardor da CA utilizado pelo RDS | `string` | `null` | no |
| <a name="input_cluster_identifier"></a> [cluster\_identifier](#input\_cluster\_identifier) | Nome do cluster que a instância pertence | `string` | `null` | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | Passa as tags dessa instância para seus respectivos snapshots | `bool` | `false` | no |
| <a name="input_db_parameter_group_name"></a> [db\_parameter\_group\_name](#input\_db\_parameter\_group\_name) | Nome do parameter group que será criado caso `create_parameter_group`  seja `true` para a instância. Senão, tentará usar um parameter group com esse nome | `string` | `null` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | Nome do subnetgroup que será atribuido à instância | `string` | `null` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | Engine utilizada pelo Aurora. Possíveis valores: `aurora`, `aurora-mysql` e `aurora-postgresql` | `string` | `null` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Versão da engine utilizada | `string` | `null` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | Tamanho e família da instância | `string` | `"db.r4.large"` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Quantidade de instâncias. Quais instâncias que serão criadas | `number` | `1` | no |
| <a name="input_instance_scope"></a> [instance\_scope](#input\_instance\_scope) | Especificar o propósito das instâncias. Exemplos: `app`, `cdc`, `extraction`, etc... | `string` | `null` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | Intervalo de tempo da coleta de métricas pelas enhanced monitoring | `number` | `60` | no |
| <a name="input_monitoring_role_arn"></a> [monitoring\_role\_arn](#input\_monitoring\_role\_arn) | ARN da role de monitoramento para habilitar o enhanced metrics | `string` | `null` | no |
| <a name="input_parameter_group_family"></a> [parameter\_group\_family](#input\_parameter\_group\_family) | Family do parameter group. Utilizar o data source `aws_rds_engine_version` para ter uma precisão melhor. | `string` | `null` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Lista de maps com os valores dos parametros que devem ser criados | <pre>list(object({<br>    name          = string<br>    value         = string<br>    apply_method  = string<br>  }))</pre> | `[]` | no |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | Habilita o performance insights | `bool` | `true` | no |
| <a name="input_performance_insights_kms_key_id"></a> [performance\_insights\_kms\_key\_id](#input\_performance\_insights\_kms\_key\_id) | Chave KMS para ser utilizada para criptografia dos dados do Performance Insights | `string` | `null` | no |
| <a name="input_preferred_backup_window"></a> [preferred\_backup\_window](#input\_preferred\_backup\_window) | Janela de backup. Determinar hora em UTC. Ex.: `04:00-06:00` LEMBRANDO QUE É UTC!!! | `string` | `null` | no |
| <a name="input_preferred_maintenance_window"></a> [preferred\_maintenance\_window](#input\_preferred\_maintenance\_window) | Janela de manutenção. Determinar data e hora em UTC. Ex.: `MON:04:00-MON:06:00` LEMBRANDO QUE É UTC!!! | `string` | `null` | no |
| <a name="input_promotion_tier"></a> [promotion\_tier](#input\_promotion\_tier) | Tier da instância para failover. Quanto menor o tier, maior a chance da instância ser escolhida como primária | `number` | `0` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Se a instância pode ser acessada publicamente. MEXER COM CUIDADO | `bool` | `false` | no |
| <a name="input_record_name"></a> [record\_name](#input\_record\_name) | Registro de DNS que será criado | `string` | `null` | no |
| <a name="input_record_ttl"></a> [record\_ttl](#input\_record\_ttl) | TTL do registro DNS | `number` | `300` | no |
| <a name="input_record_type"></a> [record\_type](#input\_record\_type) | Tipo do registro que será criado. | `string` | `"CNAME"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags para atribuir à instância | `map(string)` | `null` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Id da zona do Route53 que serão criados o registro DNS do cluster endpoint se este argumento for preenchido. Default do nome do registro será: cluster-identifier-instance-scope-ro | `string` | `null` | no |

## Outputs

No outputs.
