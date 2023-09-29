provider "aws" {
  region     = "eu-central-1"
}

resource "aws_instance" "demo" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = "demo"

  # network_interface {
  #   network_interface_id = var.network_interface_id
  #   device_index         = 0
  #   }
}
