variable "environment" {
  description = "The environment for the SNS topic (e.g., dev, staging, prod)"
  type        = string
}
variable "alert_email" {
  description = "The email address to receive alerts"
  type        = string
}