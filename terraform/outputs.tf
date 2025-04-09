# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.medusa_vpc.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.medusa_vpc.cidr_block
}

output "public_subnet_1_id" {
  description = "ID of Public Subnet 1"
  value       = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  description = "ID of Public Subnet 2"
  value       = aws_subnet.public_subnet_2.id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "public_route_table_id" {
  description = "ID of the Public Route Table"
  value       = aws_route_table.public_rt.id
}

output "route_table_association_1" {
  description = "Route Table Association for Subnet 1"
  value       = aws_route_table_association.a1.id
}

output "route_table_association_2" {
  description = "Route Table Association for Subnet 2"
  value       = aws_route_table_association.a2.id
}


# SG
output "alb_security_group_id" {
  description = "Security Group ID for ALB (medusa_sg)"
  value       = aws_security_group.medusa_sg.id
}

output "ecs_security_group_id" {
  description = "Security Group ID for ECS (medusa_ecs_sg)"
  value       = aws_security_group.medusa_ecs_sg.id
}

output "rds_security_group_id" {
  description = "Security Group ID for RDS (rds_sg)"
  value       = aws_security_group.rds_sg.id
}


# ALB
output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.medusa_alb.arn
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.medusa_alb.dns_name
}

output "target_group_arn" {
  description = "ARN of the Medusa Target Group"
  value       = aws_lb_target_group.medusa_tg.arn
}

output "http_listener_arn" {
  description = "ARN of the HTTP Listener"
  value       = aws_lb_listener.http_listener.arn
}


# ECS
output "ecs_cluster_name" {
  description = "Name of the ECS Cluster"
  value       = aws_ecs_cluster.medusa_cluster.name
}

output "ecs_task_definition_arn" {
  description = "ARN of the ECS Task Definition"
  value       = aws_ecs_task_definition.medusa_task.arn
}

output "ecs_service_name" {
  description = "Name of the ECS Service"
  value       = aws_ecs_service.medusa_service.name
}


# RDS
output "rds_endpoint" {
  description = "The connection endpoint for the Medusa PostgreSQL RDS"
  value       = aws_db_instance.medusa_postgres.endpoint
}

output "rds_db_name" {
  description = "Name of the RDS database"
  value       = aws_db_instance.medusa_postgres.db_name
}

output "rds_username" {
  description = "Username for the RDS database"
  value       = aws_db_instance.medusa_postgres.username
}

output "rds_subnet_group" {
  description = "RDS Subnet Group Name"
  value       = aws_db_subnet_group.medusa_db_subnet_group.name
}


# IAM ROLE
output "ecs_task_execution_role_name" {
  description = "Name of the IAM role for ECS task execution"
  value       = aws_iam_role.ecs_task_execution_role-db.name
}

output "ecs_task_execution_role_arn" {
  description = "ARN of the IAM role for ECS task execution"
  value       = aws_iam_role.ecs_task_execution_role-db.arn
}
