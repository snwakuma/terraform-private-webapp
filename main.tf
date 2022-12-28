# module to create IAM role and policy for the CloudWatch access
module "iam" {
  source = "./iam"
  name   = local.common_tags.company
  tags   = local.common_tags
}

# module code to create the networking related resources such as vpc, subnets, route tables & gateways
module "networking" {
  source          = "./networking"
  vpc_name        = local.common_tags.company
  cidr            = var.cidr
  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  tags            = local.common_tags


}

# module code to create the ec2 instance with user data
module "ec2" {
  source = "./ec2"
  name   = local.common_tags.company
  vpc_id = module.networking.vpc_id
  subnet_id = module.networking.private_subnets[0]    
  alb_sg_id     = module.load_balancer.alb_sg_id
  tags          = local.common_tags
  iam_role_name = module.iam.ec2_iam_role_name
}

# module code to create loadbalancer to access the ec2 instance in private subnet
module "load_balancer" {
  source         = "./load_balancer"
  name           = local.common_tags.company
  vpc_id         = module.networking.vpc_id
  instance_id    = module.ec2.instance_id
  public_subnets = module.networking.public_subnets
  tags           = local.common_tags

}
