resource "random_id" "id" {
  byte_length = 8
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}-${random_id.id.hex}"
  acl    = "private"

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_iam_role" "s3_backend_role" {
  name               = "TerraformS3BackendRole-${random_id.id.hex}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "s3_backend_policy" {
  name        = "TerraformS3BackendPolicy-${random_id.id.hex}"
  description = "Policy granting access to S3 for Terraform backend"
  policy      = data.aws_iam_policy_document.s3_backend_policy.json
}

data "aws_iam_policy_document" "s3_backend_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*"
    ]
  }
}

resource "aws_iam_role_policy_attachment" "s3_backend_policy_attachment" {
  role       = aws_iam_role.s3_backend_role.name
  policy_arn = aws_iam_policy.s3_backend_policy.arn
}
