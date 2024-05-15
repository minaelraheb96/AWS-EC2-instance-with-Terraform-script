provider "aws" {
  region = "us-east-1" // Change this to your desired region
}

resource "aws_instance" "Expleo-EC2-1" {
  ami           = "ami-04b70fa74e45c3917" // Ubuntu (free tier eligible)
  instance_type = "t2.micro"
  key_name      = "Expleo-EC2-1-key-pair" // EC2 key pair name
  
  tags = {
    Name = "Expleo EC2 1"
  }

  vpc_security_group_ids = [aws_security_group.expleo_sg.id]
  // Making the instance have a public IP address
  associate_public_ip_address = true

  // Install Ansible using cloud-init script
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install ansible -y
              EOF
}

resource "aws_security_group" "expleo_sg" {

  name        = "expleo-sg"

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 
}