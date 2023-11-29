provider "aws" {
  region = "us-east-1"  # Replace with your preferred AWS region
}
resource "aws_instance" "example" {
  ami           = "ami-0230bd60aa48260c6"  # Your specific AMI ID
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_web.id]
  tags = {
    Name = "SimpleWebApp"
  }
}
# Security group definition
resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow web inbound traffic"
  # Allow HTTP and HTTPS inbound traffic from anywhere
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
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
  # Allow SSH inbound traffic from your IP address for security
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with your actual IP address
  }
  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
  Name = "allow_web"
}
}