# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0d94353f7bad10668"
  instance_type = "t2.micro"
  user_data     = "${file("user.data.txt")}"

  tags = {
    "Terraform" = "true"
  }
}
resource "aws_s3_bucket" "my-new-S3-bucket" {
  bucket = "my-new-tf-jenkins-bucket-emaca2312"

  tags = {
    Name    = "My S3 Bucket"
    Purpose = "Project bucket for Jenkins Artifacts"
  }
}

resource "aws_s3_bucket_public_access_block" "my-new-S3-bucket" {
  bucket = aws_s3_bucket.my-new-S3-bucket.my-new-tf-jenkins-bucket-emaca2312

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_subnet" "variables-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.250.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name      = "sub-variables-us-east-1a"
    Terraform = "true"
  }
}


resource "aws_security_group" "my-new-security-group" {
  name        = "jenkins_security_group"
  description = "Allow inbound traffic on tcp 22 and tcp 8080"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow 22 from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
    ingress {
    description = "Allow 8080 from the Internet"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "web_server_inbound"
    Purpose = "my IP and internet access"
  }
}