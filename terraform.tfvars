region = "eu-west-2"

vpc_cidr = "172.16.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

enable_classiclink = "false"

enable_classiclink_dns_support = "false"

preferred_number_of_public_subnets = 2

preferred_number_of_private_subnets = 4

tags = {
  Enviroment      = "production" 
  Owner-Email     = "dele@deleonabowu.io"
  Managed-By      = "Terraform"
  Billing-Account = "1234567890"
}

name = "Terraform"
environment = "dev"

keypair = "devops2"
ami = "ami-035c5dc086849b5de"

account_no = "185439933271"

db-username = "dele"

db-password = "devopspbl"