# Lambda Function
resource "aws_lambda_function" "example" {
  function_name = var.function_name
  s3_bucket     = aws_s3_bucket.bucket.id # Referencia directa al bucket creado
  s3_key        = var.file_key
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_exec_role.arn

  environment {
    variables = {
      SQS_QUEUE_URL = var.queue_url
      SNS_TOPIC_ARN = var.topic_arn
    }
  }
}

# IAM Policy for S3 Access
resource "aws_iam_role_policy" "lambda_exec_policy" {
  name   = "${var.function_name}_policy"
  role   = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # Allow S3 access
      {
        Action = [
          "s3:GetObject"
        ],
        Effect   = "Allow",
        Resource = "${aws_s3_bucket.bucket.arn}/*"
      }
    ]
  })
}
