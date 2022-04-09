terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
  
}

resource "aws_key_pair" "admin_key" {
  key_name = "admin_key"
  public_key = file("/data/config/deployment.key.pub")
}

resource "aws_instance" "elastic" {
  ami           = var.ami_id
  instance_type = var.elastic_instance_type
  key_name = "admin_key"
  subnet_id = aws_subnet.subnet_us_east_2a.id
  vpc_security_group_ids = [
    aws_security_group.elastic.id, 
    aws_security_group.web_from_alb.id,
    aws_security_group.allow_ssh.id
  ]

  user_data = "#!/bin/bash\n yum update -y; yum install -y httpd.x86_64; systemctl start httpd.service; systemctl enable httpd.service; echo \"Hello World from $(hostname -f)\" > /var/www/html/index.html"

  connection {
    type = "ssh"
    user = "ec2-user"
    host = self.public_ip
    private_key = file("/data/config/deployment.key")
  }

  tags = {
    "Name" = "elastic"
  }
}

# 