provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
  // gets default id
}

data "aws_vpc" "vpc_id" {
  tags = {
    cost_center = "123456"
    team        = "super_project"
  }
}

//its pretty common to use tags to separate private and public sunets or assign private ip addresses no
data aws_subnet_ids "private_subnet_ids"{
  vpc_id = data.aws_vpc.default.id
  tags = {
    network ="private"
  }
}

data aws_subnet_ids "public_subnet_ids"{
  vpc_id = data.aws_vpc.default.id
  tags = {
    network ="public"
  }
}

