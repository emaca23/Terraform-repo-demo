terraform {
  backend "s3" {
    bucket = "p2-test-bucket-emaca2312"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}