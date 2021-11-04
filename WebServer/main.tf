provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "example" {
  ami                    = "ami-03a71cec707bfc3d7"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data              = <<EOF
#!/bin/bash
yum -y update
yum - y install httpd
ip='curl http://169.254.169.254/latest/meta-data/local-ipv4'
echo "<h2>WebServer with IP: $ip</h2> by Terraform!" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF

  tags = {
    Name = "webServer-terraform-example"
  }
}

resource "aws_security_group" "instance" {
  
  name = var.security_group_name

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
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