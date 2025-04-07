
# Select 2 Subnets in different AZs for RDS
resource "aws_db_subnet_group" "medusa_db_subnet_group" {
  name       = "medusa-db-subnet-group"
  subnet_ids = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  tags = {
    Name = "Medusa DB Subnet Group"
  }
}

# RDS Instance for Medusa Postgres
resource "aws_db_instance" "medusa_postgres" {
  identifier              = "medusa-postgres-db"
  engine                  = "postgres"
  engine_version          = "17.4"                         # latest as of now
  instance_class          = "db.t3.micro"                  # Free tier
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

# Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "medusa-rds-sg"
  description = "Allow Postgres inbound"
  vpc_id      = aws_vpc.medusa_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # open for test; restrict in prod
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS Security Group"
  }
}

# Allow ECS (medusa_sg) to access RDS on port 5432
resource "aws_security_group_rule" "rds_allow_medusa_sg" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.medusa_sg.id
  description              = "Allow Medusa SG to access RDS PostgreSQL"
}
