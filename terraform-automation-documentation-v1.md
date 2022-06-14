### AUTOMATE INFRASTRUCTURE WITH IAC USING TERRAFORM
---



I created an S3 bucket in the AWS console called dele-dev-terraform-bucket to store the Terraform state file

I created an IAM user called Bandelero and gave the user AdministrativeAccess permissions. 

Next I created Access Keys for AWS CLI or programmatic access and also installed Python SDK (boto3)

I ran the following command to ensure that I could programatically access my AWS resources

```
import boto3
s3 = boto3.resource('s3')
for bucket in s3.buckets.all():
    print(bucket.name)

```
My S3 bucket dele-dev-terraform-bucket details successfully retrieved


### I created main.tf in the Terraform project folder


Get list of availability zones
```
        data "aws_availability_zones" "available" {
        state = "available"
        }
```
### The data can be retrieved with data.aws_availability_zones.available.names

### Store desired region in a variable
```
variable "region" {
        default = "eu-west-2"
    }

```


### Store desired VPC CIDR range in a variable
```
variable "vpc_cidr" {
        default = "172.16.0.0/16"
    }
```
### Store other VPC desired settings in variables

```
variable "enable_dns_support" {
        default = "true"
    }    


variable "enable_dns_hostnames" {
        default ="true" 
    }


variable "enable_classiclink" {
        default = "false"
    }

variable "enable_classiclink_dns_support" {
        default = "false"
    }

```

# Declare a variable to store the desired number of public subnets, and set the default value
variable "preferred_number_of_public_subnets" {
  default = 2
}
```
provider "aws" {
  region = var.region    
   }


  

# Create VPC
resource "aws_vpc" "main" {
  cidr_block                     = var.vpc_cidr
  enable_dns_support             = var.enable_dns_support
  enable_dns_hostnames           = var.enable_dns_hostnames
  enable_classiclink             = var.enable_classiclink
  enable_classiclink_dns_support = var.enable_classiclink_dns_support

  }

# Create public subnets1
resource "aws_subnet" "public" {
  count = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr,4,count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "public-subnet"
  }

}



# Create private subnet4
resource "aws_subnet" "private4" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.16.6.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2b"

  tags = {
    Name = "private-subnet4"
  }
}


