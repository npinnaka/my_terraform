data "archive_file" "hello_zip" {
  type = "zip"
  source_file = "python/hello_lambda.py"
  output_path = "hello_lambda.zip"
}

data "archive_file" "another_hello_zip" {
  type = "zip"
  source_file = "python/another_hello_lambda.py"
  output_path = "another_hello_lambda.zip"
}


data "aws_iam_role" "example" {
  name = var.lambda_role_arn
}

resource "aws_lambda_function" "hello_lambda" {
  function_name = "hello_lambda"
  filename = data.archive_file.hello_zip.output_path
  source_code_hash = data.archive_file.hello_zip.output_base64sha256
  role = data.aws_iam_role.example.arn
  handler = "hello_lambda.lambda_handler"
  runtime = "python3.8"
  vpc_config {
    security_group_ids = var.security_groups
    subnet_ids = var.subnets
  }
  environment {
    variables = {
      greeting = "Hello"
    }
  }
}

resource "aws_lambda_function" "another_hello_lambda" {
  function_name = "another_hello_lambda"
  filename = data.archive_file.another_hello_zip.output_path
  source_code_hash = data.archive_file.another_hello_zip.output_base64sha256
  role = data.aws_iam_role.example.arn
  handler = "another_hello_lambda.lambda_handler"
  runtime = "python3.8"
  vpc_config {
    security_group_ids = var.security_groups
    subnet_ids = var.subnets
  }

  environment {
    variables = {
      greeting = "Hello"
    }
  }
}