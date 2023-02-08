provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-east-1"
}

resource "aws_s3_bucket" "bucket_idanho" {
  bucket = "bucket-idanho"
}

data "archive_file" "code_archive" {
  type        = "zip"
  source_dir  = "../src"
  output_path = "../Terraform/lambda_handler.zip"
}

resource "aws_s3_object" "code_object" {
  bucket = aws_s3_bucket.bucket_idanho.bucket
  key    = "lambda_handler.zip"
  source = data.archive_file.code_archive.output_path
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"

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

resource "aws_lambda_function" "lambda_function" {
  function_name = "lambda_handler"

  s3_bucket = aws_s3_bucket.bucket_idanho.bucket
  s3_key    = aws_s3_object.code_object.key
  role      = aws_iam_role.lambda_execution_role.arn
  handler   = "lambda_function.lambda_handler"
  runtime   = "python3.8"
}
