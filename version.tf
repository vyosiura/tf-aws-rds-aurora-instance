terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">= 3.41, < 4.0.0"
        }
        random = {
            source = "hashicorp/random"
            version = ">= 3.1, < 4.0.0"
        }
  }
    required_version = ">= 0.13, < 2.0.0"
}