variable "env" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "aws_profile" {
  type    = string
  default = "default"
}
variable "bucket" {
  type    = string
  default = "hqcbucket"
}
variable "tfkey" {
  type    = string
  default = "terraform/"
}

variable "instance_type" {
  type = string
}

variable "image_id" {
  type = string
}

variable "ec2_subnet_id" {
  type = string
}
variable "ecs_subnet_id" {
  type = string
}
variable "ecs_sg" {
  type = string
}
variable "ec2_sg" {
  type = string
}

