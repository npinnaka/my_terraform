provider "aws" {
  region = "us-east-1"
}

data "archive_file" "lambda_test_zip" {
  output_path = "lambda_test.zip"
  type        = "zip"
  source_file = "src/lambda_test.py"
}

resource "aws_iam_role" "iam_role" {
  name               = "lambda_iam_role"
  assume_role_policy = templatefile("${path.module}/templates/lambda-base-policy.tpl", {})
}

resource "aws_iam_policy" "policy" {
  name   = "cw_policy"
  policy = templatefile("${path.module}/templates/cloudwatch-policy.tpl", {})
}

#iam_policy_attachment
resource "aws_iam_policy_attachment" "policy_attachment" {
  name = "attachment"
  roles = [
  aws_iam_role.iam_role.name]
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_lambda_function" "lambda_test" {
  function_name = "lambda_test"
  handler       = "lambda_test.lambda_handler"
  role          = aws_iam_role.iam_role.arn
  filename      = "lambda_test.zip"
  runtime       = "python3.8"
}

locals {
  prefixes = {
    this-is-a-sample-bucket-pinnaka = [
      "a/",
      "b/",
    "c/"]
  }
}

resource "aws_s3_bucket" "sample_bucket" {
  bucket = uuid()
  acl    = "private"
}

resource "aws_s3_bucket_object" "folder1" {
  count  = length(local.prefixes.this-is-a-sample-bucket-pinnaka)
  bucket = aws_s3_bucket.sample_bucket.id
  acl    = "private"
  key    = local.prefixes.this-is-a-sample-bucket-pinnaka[count.index]
  source = "/dev/null"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket              = aws_s3_bucket.sample_bucket.id
  block_public_acls   = true
  block_public_policy = true
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_test.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.sample_bucket.arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  for_each = local.prefixes
  bucket   = aws_s3_bucket.sample_bucket.id
  dynamic "lambda_function" {
    for_each = each.value
    content {
      lambda_function_arn = aws_lambda_function.lambda_test.arn
      events = [
      "s3:ObjectCreated:*"]
      filter_prefix = lambda_function.value
      filter_suffix = ".json"
    }
  }
  depends_on = [
  aws_lambda_permission.allow_bucket]
}