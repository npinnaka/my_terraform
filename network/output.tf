output "default_vpc_id" {
  value = data.aws_vpc.default.id
}

output "vpc_id" {
  value = data.aws_vpc.vpc_id.id
}

output "public_subnets" {
  value = data.aws_subnet_ids.public_subnet_ids.ids
}


output "private_subnets" {
  value = data.aws_subnet_ids.private_subnet_ids.ids
}