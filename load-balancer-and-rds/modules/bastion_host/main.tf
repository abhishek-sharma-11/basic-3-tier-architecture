#--------------------------------------------------
#----------------- Security Group -----------------
#--------------------------------------------------

resource "aws_security_group" "bastion_host" {
  name        = "${var.project_name_prefix}-bastion-host"
  description = "Security group for ${var.project_name_prefix} bastion-host"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH Ingress rules Security group ${var.project_name_prefix} bastion-host"
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
    "Name" = "${var.project_name_prefix}_internal_alb"
  }
}

#------------------------------------------------
#----------------- AWS Instance -----------------
#------------------------------------------------

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  availability_zone      = "ap-south-1a"
  subnet_id              = var.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.bastion_host.id]

  tags = {
    Name = "Bastion-Host"
  }
}