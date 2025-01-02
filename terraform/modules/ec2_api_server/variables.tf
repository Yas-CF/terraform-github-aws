variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
}

variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet in which to launch the instance"
  type        = string
}

variable "ssh_access_cidr" {
  description = "CIDR block for SSH access to the instance"
  type        = string
}
