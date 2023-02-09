terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Define the AWS provider.
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

# Create an S3 bucket.
resource "aws_s3_bucket" "bucket_idanho" {
  bucket = var.bucket_name
}

# Data source for the lambda code archive
data "archive_file" "code_archive" {
  type        = "zip"  # Type of archive file
  source_dir  = "../src"  # Directory containing the source code
  output_path = "../terraform/${var.lambda_handler_zip_file}"  # Path to store the output archive
}

# S3 object for uploading the lambda code archive
resource "aws_s3_object" "code_object" {
  bucket = aws_s3_bucket.bucket_idanho.bucket  # S3 bucket name
  key    = var.lambda_handler_zip_file  # Key for the object
  source = data.archive_file.code_archive.output_path  # Source of the object
}

# IAM role for the lambda function
resource "aws_iam_role" "lambda_execution_role" {
  name = var.lambda_execution_role_name  # Name of the IAM role

  assume_role_policy = jsonencode({  # Policy for the IAM role
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",  # Action for the role
        Effect = "Allow",  # Allow access
        Principal = {
          Service = "lambda.amazonaws.com"  # Principal for the role
        }
      }
    ]
  })
}

# Create the lambda function
resource "aws_lambda_function" "lambda_function" {
  function_name = var.lambda_function_name  # Name of the lambda function

  s3_bucket = aws_s3_bucket.bucket_idanho.bucket  # S3 bucket containing the code archive
  s3_key    = aws_s3_object.code_object.key  # Key for the code archive object
  role      = aws_iam_role.lambda_execution_role.arn  # IAM role for the lambda function
  handler   = var.lambda_handler_file  # Entry point for the lambda function
  runtime   = var.python_runtime  # Python runtime for the lambda function
}

# Create the API Gateway
resource "aws_apigatewayv2_api" "api_gateway" {
  name          = var.api_gateway_name  # Name of the API Gateway
  protocol_type = var.api_gateway_protocol_type  # Protocol type for the API Gateway
}

# Integrate the API Gateway with the lambda function
resource "aws_apigatewayv2_integration" "api_gateway_integration" {
  api_id = aws_apigatewayv2_api.api_gateway.id  # ID of the API Gateway

  integration_uri    = aws_lambda_function.lambda_function.invoke_arn  # Invoke ARN of the lambda function
  integration_type   = var.api_gateway_integration_type  # Integration type for the API Gateway
  integration_method = var.api_gateway_integration_method  # Integration method for the API Gateway
}

# Create a stage for the API Gateway
resource "aws_apigatewayv2_stage" "api_gateway_stage" {
  api_id = aws_apigatewayv2_api.api_gateway.id  # ID of the API Gateway

  name        = var.api_gateway_stage_name  # Name of the API Gateway stage
  auto_deploy = true  # Auto-deploy the API Gateway stage
}

# Create a route for the API Gateway.
resource "aws_apigatewayv2_route" "api_gateway_route" {
  # ID of the API Gateway
  api_id = aws_apigatewayv2_api.api_gateway.id

  # Key of the route
  route_key = var.api_gateway_route_key

  # Target of the route, integration ID of the API Gateway
  target = "integrations/${aws_apigatewayv2_integration.api_gateway_integration.id}"
}

# Grant permission to the API Gateway to call the Lambda function.
resource "aws_lambda_permission" "api_gateway_permissions" {
  statement_id  = var.api_gateway_permissions_statement_id # Unique identifier for the permission
  action        = var.api_gateway_permissions_action # Action of the permission
  function_name = aws_lambda_function.lambda_function.function_name # Name of the Lambda function
  principal     = var.api_gateway_permissions_principal # Principal of the permission
  source_arn = "${aws_apigatewayv2_api.api_gateway.execution_arn}/*/*" # ARN of the source to grant permission to
}

# Output the URL of the API Gateway stage
output "api_gateway_url" {
  value = "${aws_apigatewayv2_stage.api_gateway_stage.invoke_url}/"
}
