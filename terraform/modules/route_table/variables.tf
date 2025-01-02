variable "vpc_id" {
  description = "The VPC ID for the route table."
}

variable "internet_gateway_id" {
  description = "The Internet Gateway ID used in public routes."
}

variable "public_subnet_id" {
  description = "The Public Subnet ID to associate with the route table."
}
