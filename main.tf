# vpc, subnet, security group, ec2 instance, key pair, and route table
provider "aws" {
  region = "us-east-2"
}

# create a VPC 
resource "aws_vpc" "my-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.vpc_name
  }
}

# subnet reason is because we want to have distinct subnets for our public and private resources
resource "aws_subnet" "p-sn" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"
  tags = {
    Name = var.subnet_name
  }
}

# create a security group
resource "aws_security_group" "my-sg" {
  vpc_id      = aws_vpc.my-vpc.id
  name        = var.sg_name
  description = "public security group"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "my-ig" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = var.ig_name
  }

}

# route table to route traffic to the internet gateway respective destinations
resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-ig.id
  }
}

# associate the route table with the subnet
resource "aws_route_table_association" "my-route-table-association" {
  subnet_id      = aws_subnet.p-sn.id
  route_table_id = aws_route_table.my-route-table.id
}


# ec2 instance
resource "aws_instance" "app_server" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.p-sn.id
  security_groups = [aws_security_group.my-sg.id]
  tags = {
    Name = var.instance_name
  }
}  