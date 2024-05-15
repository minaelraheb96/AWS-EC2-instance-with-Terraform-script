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

  // Making the instance have a public IP address
  associate_public_ip_address = true

  // Install Ansible using cloud-init script
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install ansible -y
              EOF
}
