#--------------------------------------------------
#----------------- Security Group -----------------
#--------------------------------------------------

resource "aws_security_group" "external_alb" {
  name        = "${var.project_name_prefix}-external-alb-security-group"
  description = "Security group for ${var.project_name_prefix} Internet facing ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "Ingress rules Security group ${var.project_name_prefix} Internet facing ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Ingress rules Security group ${var.project_name_prefix} Internet facing ALB"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Ingress rules Security group ${var.project_name_prefix} Internet facing ALB"
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
    "Name" = "${var.project_name_prefix}_external_alb"
  }
}

#-------------------------------------------------
#----------------- Load Balancer -----------------
#-------------------------------------------------

resource "aws_lb" "external_alb" {
  name               = "${var.project_name_prefix}-external-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.external_alb.id]
  subnets            = var.public_subnets

  enable_deletion_protection = false
}

#------------------------------------------------
#----------------- Target Group -----------------
#------------------------------------------------

resource "aws_lb_target_group" "external_alb_tg" {
  depends_on = [aws_lb.external_alb]
  name     = "${var.project_name_prefix}-external-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

#--------------------------------------------
#----------------- Listener -----------------
#--------------------------------------------

resource "aws_lb_listener" "external_alb_listener" {
  load_balancer_arn = aws_lb.external_alb.arn

  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.external_alb_tg.arn
  }
}

#--------------------------------------------------------
#----------------- Launch Configuration -----------------
#--------------------------------------------------------

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

resource "aws_launch_configuration" "external_alb_lc" {
  name          = "${var.project_name_prefix}-external-alb-lc"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  root_block_device {
    volume_size = 10  
  }

  security_groups = [aws_security_group.external_alb.id]

  key_name = "chalo-demo"

  user_data = var.user_data
}

#------------------------------------------------------
#----------------- Auto Scaling Group -----------------
#------------------------------------------------------

resource "aws_placement_group" "external_alb_apg" {
  name     = "${var.project_name_prefix}-external-alb-apg"
  strategy = "partition"
}

resource "aws_autoscaling_group" "external_alb_asg" {
  name                      = "${var.project_name_prefix}-external-alb-asg"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  placement_group           = aws_placement_group.external_alb_apg.id
  launch_configuration      = aws_launch_configuration.external_alb_lc.name
  vpc_zone_identifier       = var.public_subnets
}