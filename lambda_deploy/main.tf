provider "aws" {
  region = "us-east-1"
}
provider "archive" {}

module "lambda" {
  source = "./lambda"
}