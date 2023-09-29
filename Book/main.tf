terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "app" {
  instance_type     = "t2.micro"
  ami               = "ami-0d1ddd83282187d18"

  user_data = <<-EOF
              #!/bin/bash
              sudo service apache2 start
              EOF
}