# Configure the AWS Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "marre-test-bucket-gitactions"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}


#Lambda creation:
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "marre_iam_for_lambda" {
  name               = "marre_iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}


data "archive_file" "marre_zip_the_python_file" {
  type        = "zip"
  source_dir  = "${path.module}/app/"
  output_path = "${path.module}/app/whenDoTheyPlay.zip"
}

resource "aws_lambda_function" "marre_test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "${path.module}/app/whenDoTheyPlay.zip"
  function_name = "marre_lambda_function_name"          #
  role          = aws_iam_role.marre_iam_for_lambda.arn # This wants the resource "aws_iam_role"
  handler       = "whenDoTheyPlay.player"               # [name of file].[name of def]
  runtime       = "python3.8"                           # just a version of python
}