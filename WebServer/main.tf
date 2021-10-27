provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "example" {
  ami           = "ami-00d5329b6464d26f5"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
    #!/bin/bash
    echo "HI"> index.html
    nogup busybox httpd -f -p 8080 &
    EOF

  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
  
  name = var.security_group_name

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

variable "security_group_name" {
  description = "The name of the security group"
  type = string
  default = "terraform-example-instance"
}

output "public_ip" {
  value = aws_instance.example.public_ip
  description = "The public IP of the Instance"
}