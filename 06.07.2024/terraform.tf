terraform {
 
 backend "remote" {
    hostname = "app.terraform.io"
    organization = "emaca23_demo"

    workspaces {
      name = "my-aws-app"
    }
   }
  
  required_version = ">= 0.15.1"
    

  required_providers {
    aws = {
      source = "hashicorp/aws"

      version = "~> 5.0"
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

       
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.57.0"
    }
    }   
    }