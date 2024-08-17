variable "instance_name" {
  description = "value of Name tag for the EC2 instance"
  type        = string
  default     = "my-test"
}

variable "instance_type" {
  description = "type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "AMI for the EC2 instance"
  type        = string
  default     = "ami-0a3b805fce34f5d92"
}

variable "subnet_name" {
  description = "value of Name tag for the subnet"
  type        = string
  default     = "my-subnet"
}

variable "vpc_name" {
  description = "value of Name tag for the VPC"
  type        = string
  default     = "my-vpc"
}

variable "sg_name" {
  description = "value of Name tag for the security group"
  type        = string
  default     = "my-sg"
}

variable "ig_name" {
  description = "value of Name tag for the internet gateway"
  type        = string
  default     = "my-ig"
}

variable "route_table_name" {
  description = "value of Name tag for the route table"
  type        = string
  default     = "my-route-table"
}

variable "route_table_association_name" {
  description = "value of Name tag for the route table association"
  type        = string
  default     = "my-route-table-association"
}

