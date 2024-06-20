# Configure the AWS Provider
provider "aws" {}

resource "aws_launch_template" "project_2" {
  name          = "project2"
  image_id      = var.ami_name
  instance_type = "t2.micro"
  user_data     = filebase64("user_data.sh")
 
  
  network_interfaces {
    security_groups = ["${aws_security_group.my-new-security-group.id}"] 
    associate_public_ip_address = true
  }
  
  tags = {
    Name = "test"
  }
}

resource "aws_autoscaling_group" "p2_demo" {
  desired_capacity     = 2
  max_size             = 5
  min_size             = 2
  #launch_configuration = "${aws_launch_template.project_2.id}"
  vpc_zone_identifier  = ["subnet-003ffee4f109276c5", "subnet-018af8d8fe5ff564c"]
  
  launch_template {
    id      = aws_launch_template.project_2.id
    version = "$Latest"
  }
}

resource "aws_s3_bucket" "bucket_p2" {
  bucket = "p2-test-bucket-emaca2312"

  tags = {
    Name    = "My S3 Bucket"
    Purpose = "Project bucket for terraform_asg"
  }
}

resource "aws_security_group" "my-new-security-group" {
  name        = "p2_security_group"
  description = "Allow inbound traffic on all ports"
  vpc_id      = var.vpc_name

  ingress {
    description = "Allow all from public"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  

  tags = {
    Name    = "web_server"
    Purpose = "all traffic allowed"
  }
}