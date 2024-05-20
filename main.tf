terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.45.0"

    }
  }
  backend "s3" {
    bucket = "gabrieltesteremotestate"
    key    = "aws-ec2-pipe-git-actions/terraform.tfstate"
    region = "us-east-2"
  }

}

provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = { # colocar tags pra quando ver la a bucket mostrar q foi feito pelo pai e usado terraform
      owner      = "Gabriel"
      managed-by = "terraform"

    }
  }
}


data "terraform_remote_state" "vpc" { # aqui é um remote state para conseguier pegar as config's la da VPC que ta no S3
  backend = "s3"
  config = {
    bucket = "gabrieltesteremotestate"
    key    = "aws-vpc/terraform.tfstate"
    region = "us-east-2"
  }
}
