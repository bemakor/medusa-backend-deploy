output "vpc_id" {
  value = aws_vpc.medusa_vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.medusa_vpc.cidr_block
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]
}

output "security_group_id" {
  value = aws_security_group.medusa_sg.id
}

output "alb_dns_name" {
  value = aws_lb.medusa_alb.dns_name
}

output "medusa_db_endpoint" {
  value = aws_db_instance.medusa_db.endpoint
}


