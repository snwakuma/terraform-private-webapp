# network module variables

variable "cidr" {
  type        = string
  description = "cidr range of the vpc"
  default = "10.0.0.0/16"
}

variable "azs" {
    type = list
    description = "availability zones list"
    default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "private_subnets" {
    type = list
    description = "private subnets list"
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
    type = list
    description = "public subnets list"
    default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}