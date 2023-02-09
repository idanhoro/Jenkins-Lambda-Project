variable "secret_key" {
  type    = string

  description = "The AWS secret key for accessing the AWS resources."
}

variable "access_key" {
  type    = string

  description = "The AWS access key for accessing the AWS resources."
}

variable "region" {
  type    = string

  description = "The AWS region where the resources will be created."
}


variable "bucket_name" {
  type    = string

  description = "The name of the S3 bucket that will store the AWS Lambda code."
}

variable "lambda_handler_zip_file" {
  type    = string
  default = "lambda_handler.zip"

  description = "The name of the zip file containing the AWS Lambda function code."
}

variable "lambda_execution_role_name" {
  type    = string
  default = "lambda_execution_role"

  description = "The name of the AWS IAM role for the AWS Lambda function."
}

variable "lambda_function_name" {
  type    = string
  default = "lambda_handler"

  description = "The name of the AWS Lambda function."
}

variable "lambda_handler_file" {
  type    = string
  default = "lambda_function.lambda_handler"

  description = "The file name and entry point of the AWS Lambda function code."
}

variable "python_runtime" {
  type    = string
  default = "python3.9"

  description = "The version of Python runtime for the AWS Lambda function."
}

variable "api_gateway_name" {
  type    = string
  default = "lambda_gateway"

  description = "The name of the API Gateway that will route incoming API requests to the AWS Lambda function."
}

variable "api_gateway_protocol_type" {
  type    = string
  default = "HTTP"

  description = "The protocol used by the API Gateway for incoming API requests."
}

variable "api_gateway_integration_type" {
  type    = string
  default = "AWS_PROXY"

  description = "The type of integration used by the API Gateway to route incoming API requests to the AWS Lambda function."
}

variable "api_gateway_integration_method" {
  type    = string
  default = "POST"

  description = "The HTTP method used by the API Gateway for incoming API requests."
}

variable "api_gateway_stage_name" {
  type    = string
  default = "lambda_stage"

  description = "The name of the stage for the API Gateway."
}

variable "api_gateway_route_key" {
  type    = string
  default = "GET /"

  description = "The route key for incoming API requests in the API Gateway."
}

variable "api_gateway_permissions_statement_id" {
  type    = string
  default = "AllowExecutionFromAPIGateway"

  description = "The identifier of the AWS IAM policy statement that allows the API Gateway to invoke the AWS Lambda function."
}

variable "api_gateway_permissions_action" {
  type    = string
  default = "lambda:InvokeFunction"
  description = "The action that the API Gateway is authorized to perform on the Lambda function."
}

variable "api_gateway_permissions_principal" {
  type    = string
  default = "apigateway.amazonaws.com"
  description = "The AWS service that the API Gateway belongs to and that is authorized to perform the action on the Lambda function."
}


