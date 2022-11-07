provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAZN3FXUTQKAY4RUP2"
  secret_key = "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"
}
resource "aws_instance" "User" {
  ami           = "ami-062df10d14676e201"
  instance_type = "t2.micro"
  key_name      = "lucky"
  user_data     = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt-get update
  sudo apt-get install -y tomcat9
  echo "*** Completed Installing apache2"
  EOF
  tags = {
    "Name" = "Demo1"
  }
}
resource "aws_security_group" "sg" {
  name        = "allow_ssh_http"
  description = "Allow ssh http inbound traffic"
  vpc_id      = "vpc-03cffc0b60316e175"

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh_http"
  }
}
