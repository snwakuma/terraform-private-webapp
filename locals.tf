locals {
  common_tags={
    company = "xyz"
    owner = "xyz DevOps Team"
    team-email = "team-devops@xyz.com"
    time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
    environment = "development"
  }
 
}