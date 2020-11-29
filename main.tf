terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.17"
    }
  }
  backend "s3" {
    bucket = "bucket-tf"
    key    = "terraform/terraform.tfstate"
    region = "eu-central-1"
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

module "ecs_container" {
  source        = "./modules/ecs/"
  instance_type = var.instance_type
  image_id      = var.image_id
  aws_region    = var.aws_region
  ec2_subnet_id = var.ec2_subnet_id
  ecs_subnet_id = var.ecs_subnet_id
  ec2_sg        = var.ec2_sg
  ecs_sg        = var.ecs_sg
}

module "ec2" {
  source = "./modules/ec2/"
}

module "alarm" {
  source = "./modules/alarm/"
}
