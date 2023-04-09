# Configure the AWS Provider
provider "aws" {
  version = "~> 4.0"
  access_key = "${{ secrets.AWS_ACCESS_KEY_ID }}"
  secret_key = "${{ secrets.AWS_SECRET_ACCESS_KEY }}"
  region  = "us-east-1"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "whenDoTheyPlay.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = "lambda_function_name"
  role          = aws_iam_role.iam_for_lambda.arn # What? is this?
  handler       = "index.test" # What is this..?

  source_code_hash = data.archive_file.lambda.output_base64sha256 # This?

}