variable "instance_name" {
  description = "value of Name tag for the EC2 instance"
  type        = string
  default = "my-terraform-example"
}

variable "instance_type" {
  description = "type of EC2 instance"
  type        = string
  default = "t4g.micro"
}