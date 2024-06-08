terraform {

  backend "s3" {
    bucket = "my-terraform-state-ejc"
    key    = "path/to/my/key"
    region = "us-east-1"
    
    dynamodb_table = "terraform-locs"
    encrypt = true
  }

  required_version = ">= 0.15.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"

      version = "~> 5.0"
    }


  required_version = ">= 0.15.1"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }

    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
    tls = {

      source = "hashicorp/tls"

      version = "4.0.5"

    }
  }

      source  = "hashicorp/tls"
      version = "3.1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.57.0"
    }
  }
}

terraform {
  backend "local" {
    path = "mystate/terraform.tfstate"
  }

}