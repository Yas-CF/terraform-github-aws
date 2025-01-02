variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
}

variable "cpu_threshold" {
  description = "Threshold for CPU utilization"
  type        = number
  default     = 80
}

variable "disk_threshold" {
  description = "Threshold for disk space utilization"
  type        = number
  default     = 90
}

variable "memory_threshold" {
  description = "Threshold for memory utilization"
  type        = number
  default     = 80
}

variable "topic_arn" {
  description = "The ARN of the SNS topic for alerts"
  type        = string
}
