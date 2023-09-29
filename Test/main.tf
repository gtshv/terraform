provider "aws" {
  region     = "eu-central-1"
}

resource "aws_instance" "web" {
  ami                    = "ami-0a261c0e5f51090b1" // EC2
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  key_name               = "demo"
  monitoring             = false
  #    user_data         = "yum install http" // 1 row
  user_data = <<EOF
#!/bin/bash
yum -y update
yum install httpd -y
MYIP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with PrivateIP: $MYIP</h2></br> Built by Terraform" > /var/www/html/index.html
service httpd start
chkconfig httpd on
EOF

  tags = {
    Name  = "Webserver Build by Terraform"
    Owner = "Galin Toshev"
  }
}

resource "aws_security_group" "web" {
  name        = "Web server"
  description = "Demo"

  ingress {
    description = "galin.toshev"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow ALL port"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name  = "Build by Terraform"
    Owner = "Galin Toshev"
  }
}
  output "public_ip" {
    value = aws_instance.web.public_ip
  }
  output "public_dns" {
    value = aws_instance.web.public_dns
  }