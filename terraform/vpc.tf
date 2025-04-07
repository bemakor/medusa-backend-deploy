variable "db_password" {
  default = "1StMedusdb"
}

# DB Subnet Group
resource "aws_db_subnet_group" "medusa_db_subnet_group" {
  name       = "medusa-db-subnet-group"
  subnet_ids = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  tags = {
    Name = "Medusa DB Subnet Group"
  }
}

# RDS Security Group
resource "aws_security_group" "medusa_rds_sg" {
  name        = "medusa-rds-sg"
  description = "Allow PostgreSQL access"
  vpc_id      = aws_vpc.medusa_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Medusa RDS SG"
  }
}

# PostgreSQL RDS
resource "aws_db_instance" "medusa_db" {
  identifier              = "medusa-db"
  engine                  = "postgres"
  engine_version          = "15.4"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  db_name                 = "medusadb"
  username                = "medusaadmin"
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.medusa_db_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.medusa_rds_sg.id]
  publicly_accessible     = true
  skip_final_snapshot     = true
  deletion_protection     = false

  tags = {
    Name = "Medusa PostgreSQL DB"
  }
}
