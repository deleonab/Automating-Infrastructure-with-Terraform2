

variable "region" {
  default = "eu-west-2"
}



variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "enable_dns_support" {
  type = bool
}


variable "enable_dns_hostnames" {
  type = bool
}


variable "enable_classiclink" {
  type = bool
}

variable "enable_classiclink_dns_support" {
 type = bool
}


# Declare a variable to store the desired number of public subnets, and set the default value
variable "preferred_number_of_public_subnets" {
  type = number
}

# Declare a variable to store the desired number of public subnets, and set the default value
variable "preferred_number_of_private_subnets" {
  type = number
}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

variable "name"{

  type=string
}

variable "environment"{

  type=string
}

variable "ami" {

  type = string
  description = "EC2 AMI for launch template and ASG"
}

variable "keypair" {
type = string
 description = "Keypair for secure connections"
}


variable "account_no" {
  type        = number
  description = "the account number"
}

variable "db-username" {
  type        = string
  description = "RDS admin username"
}

variable "db-password" {
  type        = string
  description = "RDS master password"
}