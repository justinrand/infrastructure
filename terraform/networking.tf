resource "aws_vpc" "main" {
  cidr_block = "172.31.0.0/16"
  instance_tenancy = "default"

  tags = {
    "Name" = "my_default"
  }
}

resource "aws_subnet" "subnet_us_east_2a" {
    availability_zone = "us-east-2a"
    vpc_id = aws_vpc.main.id
    cidr_block = "172.31.0.0/20"  
    map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_us_east_2b" {
    availability_zone = "us-east-2b"
    vpc_id = aws_vpc.main.id
    cidr_block = "172.31.16.0/20"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_us_east_2c" {
    availability_zone = "us-east-2c"
    vpc_id = aws_vpc.main.id
    cidr_block = "172.31.32.0/20"
    map_public_ip_on_launch = true
}