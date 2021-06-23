module "vault_demo_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.environment_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = [var.availability_zones]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  tags = {
    Name = "${var.environment_name}-vpc"
  }
}


resource "aws_lb_target_group" "vault-elb" {
  name        = "vault-elb"
  port        = 8200
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = "vpc-03d128af18c6998c3"
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.test.id
  port             = 80
}