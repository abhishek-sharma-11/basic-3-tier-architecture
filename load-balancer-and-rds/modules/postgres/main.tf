#--------------------------------------------------
#----------------- Security Group -----------------
#--------------------------------------------------

resource "aws_security_group" "postgres" {
  name        = "${var.project_name_prefix}-postgres-security-group"
  description = "Security group for ${var.project_name_prefix} postgres"
  vpc_id      = var.vpc_id

  ingress {
    description = "Ingress rules Security group ${var.project_name_prefix} postgres"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Ingress rules Security group ${var.project_name_prefix} postgres"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.project_name_prefix}-postgres"
  }
}

#------------------------------------------------
#----------------- Subnet Group -----------------
#------------------------------------------------

resource "aws_docdb_subnet_group" "postgres_subnet_group" {
  name       = "${var.project_name_prefix}-postgres-subnet-group"
  subnet_ids = var.private_subnets
}

#--------------------------------------------
#----------------- Postgres -----------------
#--------------------------------------------


resource "aws_db_instance" "postgres" {
  identifier             = "${var.project_name_prefix}-postgres" 
  allocated_storage      = 10
  max_allocated_storage  = 30

  engine                 = "postgres"
  engine_version         = "14"
  instance_class         = "db.t3.micro"

  db_name                = "mydb"
  username               = "foo"
  password               = "foobarbaz"
  port                   = 5432
  
  skip_final_snapshot    = true

  multi_az               = true
  db_subnet_group_name   = aws_docdb_subnet_group.postgres_subnet_group.name
  vpc_security_group_ids = [aws_security_group.postgres.id]
}
