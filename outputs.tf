output "vpc_id" {
    value = module.networking.vpc_id
}


output "private_subnets" {
    value = module.networking.private_subnets
}


output "public_subnets" {
    value = module.networking.public_subnets
}

output "ec2_iam_role" {
  value = module.iam.ec2_iam_role
}

output "ec2_iam_role_name" {
  value = module.iam.ec2_iam_role_name
}

output "instance_id" {
    value = module.ec2.instance_id
}

output "alb_sg_id" {
    value = module.load_balancer.alb_sg_id
}

output "alb_dns" {
    value = module.load_balancer.alb_dns
}