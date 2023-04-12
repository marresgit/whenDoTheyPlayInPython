# Configure the AWS Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.62.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

#data "archive_file" "lambda" {
#  type        = "zip"
#  source_file = "whenDoTheyPlay.py"
#  output_path = "lambda_function_payload.zip"
#}

#resource "aws_lambda_function" "test_lambda" {
#  # If the file is not in the current working directory you will need to include a
#  # path.module in the filename.
#  filename      = "lambda_function_payload.zip"
#  function_name = "lambda_function_name"
#  role          = aws_iam_role.iam_for_lambda.arn # What? is this?
#  handler       = "index.test" # What is this..?
#
#  source_code_hash = data.archive_file.lambda.output_base64sha256 # This?
#
#}