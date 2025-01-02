resource "aws_iam_role" "lambda_exec_role" {
  name = "${var.function_name}_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_exec_policy" {
  name   = "${var.function_name}_policy"
  role   = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [

      {
        Action = [
          "s3:GetObject"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:s3:::${var.bucket_name}/*"
      },
      # Permitir acceso a SQS para recibir mensajes
      {
        Effect = "Allow",
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ],
        Resource = var.queue_arn
      },
      # Permitir acceso a SNS para publicar notificaciones
      {
        Effect = "Allow",
        Action = [
          "sns:Publish"
        ],
        Resource = var.topic_arn
      },
      # Permitir acceso a CloudWatch Logs
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_lambda_function" "example" {
  function_name = var.function_name
  s3_bucket     = var.bucket_name
  s3_key        = var.file_key
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  role          = aws_iam_role.lambda_exec_role.arn

  environment {
    variables = {
      SQS_QUEUE_URL = var.queue_url
      SNS_TOPIC_ARN = var.topic_arn
    }
  }
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = var.queue_arn
  function_name    = aws_lambda_function.example.arn
  batch_size       = 10
  enabled          = true
}

resource "aws_lambda_function_event_invoke_config" "sns_destination" {
  function_name = aws_lambda_function.example.function_name

  destination_config {
    on_success {
      destination = var.topic_arn
    }
  }
}
