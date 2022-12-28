variable "vpc_name" {
  type        = string
  description = "name of the vpc"
}


variable "cidr" {
  type        = string
  description = "cidr range of the vpc"
}

variable "azs" {
    type = list
    description = "availability zones list"
    
}

variable "private_subnets" {
    type = list
    description = "private subnets list"
    
}

variable "public_subnets" {
    type = list
    description = "public subnets list"
    
}

variable "tags" {
  type = map
  description = "tags for the vpc module"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = join("", [var.vpc_name, "-", "vpc"])
  cidr = var.cidr

  azs             = var.azs
  private_subnets = var.public_subnets
  public_subnets  = var.private_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = var.tags
}
