provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-east-1"
}

resource "aws_s3_bucket" "bucket_idanho" {
  bucket = "bucket-idanho55"
}

data "archive_file" "code_archive" {
  type        = "zip"
  source_dir  = "../src"
  output_path = "../terraform/lambda_handler.zip"
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
  runtime   = "python3.9"
}

resource "aws_apigatewayv2_api" "api_gateway" {
  name          = "serverless_lambda_gw"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "api_gateway_integration" {
  api_id = aws_apigatewayv2_api.api_gateway.id

  integration_uri    = aws_lambda_function.lambda_function.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_stage" "api_gateway_stage" {
  api_id = aws_apigatewayv2_api.api_gateway.id

  name        = "serverless_lambda_stage"
  auto_deploy = true
}

resource "aws_apigatewayv2_route" "api_gateway_route" {
  api_id = aws_apigatewayv2_api.api_gateway.id

  route_key = "GET /"
  target    = "integrations/${aws_apigatewayv2_integration.api_gateway_integration.id}"
}

resource "aws_lambda_permission" "api_gateway_permissions" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.api_gateway.execution_arn}/*/*"
}

output "api_gateway_url" {
  value = "${aws_apigatewayv2_stage.api_gateway_stage.invoke_url}/"
}