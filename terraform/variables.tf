variable "aws_region" {
  description = "The AWS region to deploy resources into"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
}

variable "ssh_access_cidr" {
  description = "CIDR block for SSH access"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to use for the EC2 instances"
}
variable "instance_type" {
  description = "Type of EC2 instance to deploy"
  default     = "t2.micro"
}

variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket to store Lambda code"
}

variable "file_key" {
  description = "The S3 key for the Lambda code ZIP file"
}

variable "function_name" {
  description = "The name of the Lambda function"
}

variable "file_path" {
  description = "The local path to the file to be uploaded to S3."
}

variable "cpu_threshold" {
  description = "The CPU utilization threshold for alarms"
  type        = number
  default     = 80
}

variable "alert_email" {
  description = "The email address to receive alerts"
  type        = string
}

variable "disk_threshold" {
  description = "Disk utilization threshold"
  type        = number
  default     = 90
}

variable "memory_threshold" {
  description = "Memory utilization threshold"
  type        = number
  default     = 80
}