provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}

resource "aws_instance" "ec2_instance" {
    ami = "${var.ami_id}"
    count = "${var.number_of_instances}"
    subnet_id = "${var.subnet_id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.ami_key_pair_name}"
    tags = {
    Name = "test-jenkins"
  }

}

  resource "aws_lb" "application" {
  name               = "my-application-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["xxxx"]  # Replace with your security group ID
  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true
  enable_http2                     = true
  idle_timeout                     = 60
  subnets            = [xxxx]

}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.application.arn
  port              = 80
  protocol          = "HTTP"
 
 default_action {
    type = "redirect"
    redirect {
      protocol    = "HTTPS"
      port        = "443"
      query       = true
      path        = "/#{path}"  # Include path using the #{path} variable
      host        = "#{host}"
      status_code = "HTTP_301"
    }
  }
  tags = {
    Scope = "Jenkins"
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.application.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "axxxxx"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins.arn
  }

tags = {
    Scope = "Jenkins"
  }

}

resource "aws_lb_target_group" "jenkins" {
  name        = "jenkins-tg"
  port        = 8080
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "vxxxxxxxxx"  # Replace with your VPC ID
}


resource "aws_lb_target_group_attachment" "jenkins_attachment" {
  target_group_arn = aws_lb_target_group.jenkins.arn
  target_id        = aws_instance.ec2_instance[0].id
}
