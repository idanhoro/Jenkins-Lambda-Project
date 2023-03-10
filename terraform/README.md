## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.3.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.53.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_apigatewayv2_api.api_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api) | resource |
| [aws_apigatewayv2_integration.api_gateway_integration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_integration) | resource |
| [aws_apigatewayv2_route.api_gateway_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_route) | resource |
| [aws_apigatewayv2_stage.api_gateway_stage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_stage) | resource |
| [aws_iam_role.lambda_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_lambda_function.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.api_gateway_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket.bucket_idanho](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_object.code_object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [archive_file.code_archive](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_key"></a> [access\_key](#input\_access\_key) | The AWS access key for accessing the AWS resources. | `string` | n/a | yes |
| <a name="input_api_gateway_integration_method"></a> [api\_gateway\_integration\_method](#input\_api\_gateway\_integration\_method) | The HTTP method used by the API Gateway for incoming API requests. | `string` | `"POST"` | no |
| <a name="input_api_gateway_integration_type"></a> [api\_gateway\_integration\_type](#input\_api\_gateway\_integration\_type) | The type of integration used by the API Gateway to route incoming API requests to the AWS Lambda function. | `string` | `"AWS_PROXY"` | no |
| <a name="input_api_gateway_name"></a> [api\_gateway\_name](#input\_api\_gateway\_name) | The name of the API Gateway that will route incoming API requests to the AWS Lambda function. | `string` | `"lambda_gateway"` | no |
| <a name="input_api_gateway_permissions_action"></a> [api\_gateway\_permissions\_action](#input\_api\_gateway\_permissions\_action) | The action that the API Gateway is authorized to perform on the Lambda function. | `string` | `"lambda:InvokeFunction"` | no |
| <a name="input_api_gateway_permissions_principal"></a> [api\_gateway\_permissions\_principal](#input\_api\_gateway\_permissions\_principal) | The AWS service that the API Gateway belongs to and that is authorized to perform the action on the Lambda function. | `string` | `"apigateway.amazonaws.com"` | no |
| <a name="input_api_gateway_permissions_statement_id"></a> [api\_gateway\_permissions\_statement\_id](#input\_api\_gateway\_permissions\_statement\_id) | The identifier of the AWS IAM policy statement that allows the API Gateway to invoke the AWS Lambda function. | `string` | `"AllowExecutionFromAPIGateway"` | no |
| <a name="input_api_gateway_protocol_type"></a> [api\_gateway\_protocol\_type](#input\_api\_gateway\_protocol\_type) | The protocol used by the API Gateway for incoming API requests. | `string` | `"HTTP"` | no |
| <a name="input_api_gateway_route_key"></a> [api\_gateway\_route\_key](#input\_api\_gateway\_route\_key) | The route key for incoming API requests in the API Gateway. | `string` | `"GET /"` | no |
| <a name="input_api_gateway_stage_name"></a> [api\_gateway\_stage\_name](#input\_api\_gateway\_stage\_name) | The name of the stage for the API Gateway. | `string` | `"lambda_stage"` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the S3 bucket that will store the AWS Lambda code. | `string` | n/a | yes |
| <a name="input_lambda_execution_role_name"></a> [lambda\_execution\_role\_name](#input\_lambda\_execution\_role\_name) | The name of the AWS IAM role for the AWS Lambda function. | `string` | `"lambda_execution_role"` | no |
| <a name="input_lambda_function_name"></a> [lambda\_function\_name](#input\_lambda\_function\_name) | The name of the AWS Lambda function. | `string` | `"lambda_handler"` | no |
| <a name="input_lambda_handler_file"></a> [lambda\_handler\_file](#input\_lambda\_handler\_file) | The file name and entry point of the AWS Lambda function code. | `string` | `"lambda_function.lambda_handler"` | no |
| <a name="input_lambda_handler_zip_file"></a> [lambda\_handler\_zip\_file](#input\_lambda\_handler\_zip\_file) | The name of the zip file containing the AWS Lambda function code. | `string` | `"lambda_handler.zip"` | no |
| <a name="input_python_runtime"></a> [python\_runtime](#input\_python\_runtime) | The version of Python runtime for the AWS Lambda function. | `string` | `"python3.9"` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where the resources will be created. | `string` | n/a | yes |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | The AWS secret key for accessing the AWS resources. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_gateway_url"></a> [api\_gateway\_url](#output\_api\_gateway\_url) | Output the URL of the API Gateway stage |
