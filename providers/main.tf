provider "aws" {
  
  region = "us-east-1"
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  
  tags = {
    Name = var.vpc_name
    Environment = "demo_environment"
    Terraform = "true"
  }
}

#Create EIP for NAT Gateway
resource "aws_eip" "nat_gateway_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.internet_gateway]
  tags = {
    Name = "demo_igw_eip"
  }
}

#Create NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  depends_on    = [aws_subnet.public_subnets]
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public_subnets["public_subnet_1"].id
  tags = {
    Name = "demo_nat_gateway"
  }
}

#Create a ec2 instance
resource "aws_instance" "web" {
  ami           = "ami-0d94353f7bad10668"
  instance_type = "t2.micro"
  #subnet_id = aws_subnet.public_subnets["public_subnet_1"].id
  subnet_id = "subnet-018af8d8fe5ff564c"
  vpc_security_group_ids = ["sg-0db48206c73ccafc5"]

  tags = {
    "Terraform" = "true"
  }
}


resource "aws_s3_bucket_ownership_controls" "my_new_bucket_acl" {   
  bucket = aws_s3_bucket.my-new-S3-bucket.id  
  rule {     
    object_ownership = "BucketOwnerPreferred"   
  }
}



resource "aws_subnet" "variables-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "var.variables_sub_cidr"
  availability_zone       = "var.variables_sub_az"
  map_public_ip_on_launch = "var.variables_sub_auto_ip"

  tags = {
    Name      = "sub-variables-${var.variables_sub_az}"
    Terraform = "true"
  
