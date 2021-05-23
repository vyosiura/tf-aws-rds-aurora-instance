terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">= 3.41"
        }
    }
    required_providers {
        random = {
            source = "hashicorp/random"
            version = ">= 3.1"
        }
  }
    required_version = ">= 0.13"
}