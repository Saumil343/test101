resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_execution_policy" {
  name        = "lambda_execution_policy"
  description = "Permissions for Lambda execution"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "lambda:InvokeFunction",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "administrator_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_lambda_function" "sms_processor" {
  function_name = "sms_processor"
  runtime       = "python3.8"
  handler       = "lambda_function.lambda_handler"
  timeout       = 10
  memory_size   = 128

  role = aws_iam_role.lambda_role.arn

  filename      = "lambda_function.zip"  # Path to your Lambda function deployment package

  # source_code_hash = filebase64sha256("lambda_function.zip")  # Compute the hash of your deployment package

#   # Add a resource-based policy for API Gateway
#   resource_based_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "apigateway.amazonaws.com"
#       },
#       "Action": "lambda:InvokeFunction",
#       "Resource": "${aws_lambda_function.sms_processor.arn}"
#     }
#   ]
# }
# EOF
}

resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sms_processor.arn

  principal     = "apigateway.amazonaws.com"

  # Specify the ARN of your API Gateway resource here
  source_arn    = "arn:aws:execute-api:us-east-1:576246433174:*/*/*/*"

  # Replace <region>, <account_id>, and <api_gateway_id> with the actual values
  # Region: The region where your API Gateway is deployed
  # Account ID: Your AWS account ID
  # API Gateway ID: The ID of your API Gateway
}
