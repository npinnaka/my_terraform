variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "lambda_role_arn" {
  default = "lambda_role" // I created this role in aws... will add role create terraform in future
}

variable "subnets" {
  type = list(string)
  default = [
    "subnet-ecfd0d8a",
    "subnet-2611916b",
    "subnet-2542bd04",
    "subnet-e47a87bb",
    "subnet-e14641df",
  "subnet-1775df19"]
}

variable "security_groups" {
  type = list(string)
  default = [
    "sg-85ae32a4"
  ]
}