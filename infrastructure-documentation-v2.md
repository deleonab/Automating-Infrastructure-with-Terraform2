### Next was to create the 4 private subnets in our VPC
# create private subnets
```
resource "aws_subnet" "private" {
  count                   = var.preferred_number_of_private_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  map_public_ip_on_launch = true
 availability_zone  = data.aws_availability_zones.available.names[count.index]
 }
```

I got an error running terraform plan pointing to the AZ index count for the private subnets.

![private subnet error](./images/error-index-1.JPG)




-- This error got fixed by wrapping the AZ list in an element function

```
resource "aws_subnet" "private" {
  count                   = var.preferred_number_of_private_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  map_public_ip_on_launch = true
 availability_zone = element(data.aws_availability_zones.available.names[*], count.index)
 }
```

### Before continuing, let's implement tagging for all our resources

### Here, I will create the tag variable in variables.tf
```
variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}
```
### create the site wide default tags to be appended to the distinct tags later
```
tags = {
  Enviroment      = "production" 
  Owner-Email     = "dele@deleonabowu.io"
  Managed-By      = "Terraform"
  Billing-Account = "1234567890"
}
```

### To tag our resources we can merge the default tags with the resource name
```
tags = merge(
    var.tags,
    {
      Name = "Name of the resource"
    },
  )
  ```

 ### We shall use the format function to append the default tags to our resource name
  ```
  Name = format("%s-PrivateSubnet-%s",var.name,count.index)
  ```

  ### We also need to ensure that the ip addresses in private and public subnets do not overlap.This we do by adding 2 to count.index for the private subnet cidrsubnet()

  ```
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + 2)
  ```

  ```
  resource "aws_subnet" "private" {
  count                   = var.preferred_number_of_private_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index + 2)
  map_public_ip_on_launch = true
 //availability_zone       = data.aws_availability_zones.available.names[count.index]
 availability_zone = element(data.aws_availability_zones.available.names[*], count.index)
 }
```


### The next resource to create will be the Internet Gateway

```
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-IGW-%s",name.value,vpc.main.id)
  }
}
```






