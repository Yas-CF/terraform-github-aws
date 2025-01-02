resource "aws_sqs_queue" "example" {
  name = "${var.environment}-example-queue"

  tags = {
    Environment = var.environment
  }
}