variable "engine_version" {
    type        = string 
}

variable "engine" {
    type        = string 
}

variable "region" {
    type        = string
    description = "AWS Region"
}

variable "profile" {
    type        = string
    description = "AWS Profile"
}

variable "vpc_id" {
    type    = string
}

variable "db_subnet_group_name" {
    type    = string
}

variable "cluster_identifier" {
    type      = string 
}

variable "parameter_group_family" {
    type      = string   
}

variable "tags" {
    type      = map(string) 
}

variable "monitoring_role_arn" {
    type      = string  
}