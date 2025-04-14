data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_lb" "my_elb" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ec2_sg.id, aws_security_group.elb_sg.id]
  subnets            = data.aws_subnets.default.ids

  enable_deletion_protection = false
  
  tags = {
    Environment = "production"
  }
}
