# Terraform infrastructure code to create the VPC with public & private subnets with NAT's, Route tables, IAM Roles, CloudWatch Agent
- Will create EC2 instance, in the private subnet
- Attach load balancer to the EC2 instance for the access in the private subnet instances
- Sends EC2 access logs to the CloudWatch log group, by automatically installing the CloudWatch Agent on the EC2, as part of user data.

## Deployment steps 

Clone the repo with command `git clone https://github.com/cvamsikrishna11/private-ec2-with-public-elb.git`

Change directory into `cd private-ec2-with-public-elb`

Replace the profile name in the provider.tf

Initialize the project `terraform init`

Plan the project `terraform plan`

Deploy the infra code with `terraform apply` enter yes, when prompts for approval

Note: To destroy `terraform destroy` enter yes, when prompts for approval


Reference: 
1. https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
2. https://medium.com/tensult/to-send-linux-logs-to-aws-cloudwatch-17b3ea5f4863