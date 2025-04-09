# 2 SUBNETS FOR RDS
resource "aws_db_subnet_group" "medusa_db_subnet_group" {
  name       = "medusa-db-subnet-group"
  subnet_ids = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  tags = {
    Name = "Medusa DB Subnet Group"
  }
}

# RDS INSTANCE - POSTGRES
resource "aws_db_instance" "medusa_postgres" {
  identifier              = "medusa-postgres-db"
  engine                  = "postgres"
  engine_version          = "17.4"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  storage_type            = "gp2"
  db_name                 = "medusadb"
  username                = "medusaadmin"
  password                = "1StMedusdb"
  publicly_accessible     = true
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.medusa_db_subnet_group.name
  skip_final_snapshot     = true
  deletion_protection     = false
  iam_database_authentication_enabled = true
  apply_immediately       = true
  port                    = 5432

  tags = {
    Name = "MedusaPostgres"
  }
}

# CONNECTION BETWEEN ECS AND RDS
resource "aws_security_group_rule" "rds_allow_medusa_sg" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.medusa_sg.id
  description              = "Allow Medusa SG to access RDS PostgreSQL"
}
