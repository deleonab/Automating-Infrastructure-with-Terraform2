
provider "aws" {
  region = var.region
}

# Get list of availability zones
data "aws_availability_zones" "available" {
  state = "available"
}



# Create VPC
resource "aws_vpc" "main" {
  cidr_block                     = var.vpc_cidr
  enable_dns_support             = var.enable_dns_support
  enable_dns_hostnames           = var.enable_dns_hostnames
  enable_classiclink             = var.enable_classiclink
  enable_classiclink_dns_support = var.enable_classiclink_dns_support

}

# Create public subnets
resource "aws_subnet" "public" {
  count                   = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
tags = merge(
    var.tags,
    {
      Name = format("%s-PublicSubnet-%s",var.name,count.index)
    } 
  )

}

# create private subnets
resource "aws_subnet" "private" {
  count                   = var.preferred_number_of_private_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index + 2)
  map_public_ip_on_launch = true
 //availability_zone       = data.aws_availability_zones.available.names[count.index]
 availability_zone = element(data.aws_availability_zones.available.names[*], count.index)
 tags = merge(
    var.tags,
    {
      Name = format("%s-PrivateSubnet-%s",var.name,count.index)
    } 
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = format("%s-IGW-%s",var.name,var.environment)
    } 
  )
}


resource "aws_eip" "nat_eip" {
  vpc = true

  depends_on = [aws_internet_gateway.igw]
 tags = merge(
    var.tags,
    {
      Name = format("%s-NATEIP-%s",var.name,var.environment)
    } 
  ) 

}


resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public.*.id,0)
  depends_on = [aws_internet_gateway.igw]
 tags = merge(
    var.tags,
    {
      Name = format("%s-NATGW-%s",var.name,var.environment)
    } 
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  
}


 # create private route table
resource "aws_route_table" "private-rtb" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = format("%s-Private-Route-Table", var.name)
    },
  )
}

# create route for the private route table and attach the nat gateway

resource "aws_route" "private_rtb_route" {
    route_table_id = aws_route_table.private-rtb.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

# associate all private subnets to the private route table

resource "aws_route_table_association" "private_subnet_assoc" {
    
    count = length(aws_subnet.private[*].id)
    subnet_id = element(aws_subnet.private[*].id, count.index)
    route_table_id = aws_route_table.private-rtb.id
  }



# create route table for the public subnets
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = format("%s-Public-Route-Table", var.name)
    },
  )
}

# create route for the public route table and attach the internet gateway
resource "aws_route" "public-rtb-route" {
  route_table_id         = aws_route_table.public-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# associate all public subnets to the public route table
resource "aws_route_table_association" "public-subnets-assoc" {
  count          = length(aws_subnet.public[*].id)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public-rtb.id
}