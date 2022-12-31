#--------------------------------------------------
#----------------- Security Group -----------------
#--------------------------------------------------

resource "aws_security_group" "internal_alb" {
  name        = "${var.project_name_prefix}-internal-alb-security-group"
  description = "Security group for ${var.project_name_prefix} Internal ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "Ingress rules Security group ${var.project_name_prefix} Internal ALB"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Ingress rules Security group ${var.project_name_prefix} Internal ALB"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.my_ip_cidr
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

#-------------------------------------------------
#----------------- Load Balancer -----------------
#-------------------------------------------------

resource "aws_lb" "internal_alb" {
  name               = "${var.project_name_prefix}-internal-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.internal_alb.id]
  subnets            = var.private_subnets

  enable_deletion_protection = var.enable_deletion_protection
}

#------------------------------------------------
#----------------- Target Group -----------------
#------------------------------------------------

resource "aws_lb_target_group" "internal_alb_tg" {
  depends_on = [aws_lb.internal_alb]
  name     = "${var.project_name_prefix}-internal-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

#--------------------------------------------
#----------------- Listener -----------------
#--------------------------------------------

resource "aws_lb_listener" "internal_alb_listener" {
  load_balancer_arn = aws_lb.internal_alb.arn

  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal_alb_tg.arn
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

resource "aws_launch_configuration" "internal_alb_lc" {
  name          = "${var.project_name_prefix}-internal-alb-lc"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.internal_alb_lc_instance_type

  root_block_device {
    volume_size = var.internal_alb_lc_root_volume 
  }

  security_groups = [aws_security_group.internal_alb.id]

  key_name = var.key_pair_name

  user_data = var.user_data
}

#------------------------------------------------------
#----------------- Auto Scaling Group -----------------
#------------------------------------------------------

resource "aws_placement_group" "internal_alb_apg" {
  name     = "${var.project_name_prefix}-internal-alb-apg"
  strategy = "partition"
}

resource "aws_autoscaling_group" "internal_alb_asg" {
  name                      = "${var.project_name_prefix}-internal-alb-asg"
  max_size                  = var.internal_alb_asg_max_size
  min_size                  = var.internal_alb_asg_min_size
  desired_capacity          = var.internal_alb_asg_desried_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  placement_group           = aws_placement_group.internal_alb_apg.id
  launch_configuration      = aws_launch_configuration.internal_alb_lc.name
  vpc_zone_identifier       = var.private_subnets
}