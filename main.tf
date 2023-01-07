# Create EC2 Instance
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = var.name

  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.keyname
  monitoring             = true
  vpc_security_group_ids = [ aws_security_group.public.id ]
  subnet_id              = var.subnet_id
  user_data              = "${file("./install.sh")}"

  root_block_device      = var.root_block_device

  tags = {
    Name        = var.aws_dbsvr_tag_name
    Environment = var.aws_dbsvr_tag_env
    Account     = var.aws_dbsvr_tag_acct
    Task        = var.aws_dbsvr_tag_task
    Initiator   = var.aws_dbsvr_tag_initr
  }
}

resource "aws_eip" "this" {
  vpc      = true
  instance = "${module.ec2_instance.id}"
}

resource "aws_security_group" "public" {
  name = "${var.name}-public-sg"
  description = "Public internet access"
  vpc_id = var.vpc_id
 
  tags = {
    Name        = "${var.name}-public-sg"
    Role        = "public"
    Project     = var.name
  }
}

resource "aws_security_group_rule" "public_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 
  security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}
 
resource "aws_security_group_rule" "public_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}
 
resource "aws_security_group_rule" "public_in_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}
