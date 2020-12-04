terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
  
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_key_pair" "admin_key" {
  key_name = "admin_key"
  public_key = file("/home/oper/.ssh/id_rsa.pub")
}

resource "aws_instance" "example" {
  ami           = "ami-03657b56516ab7912"
  instance_type = "t2.micro"
  key_name = "admin_key"

  vpc_security_group_ids = [aws_security_group.elastic2.id, aws_security_group.web443.id]

  provisioner "remote-exec" {
    inline = [
      "sudo yum -qq install pip -y",
      "echo hello"
    ]
  }
  
  provisioner "local-exec" {
    command = "ansible-playbook -i ${self.public_ip} -u ec2-user playbooks/base.yml"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    host = self.public_ip
    private_key = file("private.key")
  }
}

resource "aws_vpc" "main" {
  cidr_block = "172.31.0.0/16"
  instance_tenancy = "default"
}

resource "aws_security_group" "web443" {
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 443
    protocol = "tcp"
  }
}

resource "aws_security_group" "elastic2" {
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }

  ingress {
    cidr_blocks = ["172.31.0.0/16"]
    from_port = 9200
    to_port = 9200
    protocol = "tcp"
    self = true
  }

  ingress {
    cidr_blocks = ["172.31.0.0/16"]
    from_port = 9300
    to_port = 9300
    protocol = "tcp"
    self = false
  }


  ingress {
    cidr_blocks = ["96.255.42.144/32"]
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = false
  }

  ingress {
    cidr_blocks = ["96.255.42.144/32"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
    self = true
  }

  ingress {
    cidr_blocks = ["96.255.42.144/32"]
    from_port = 5601
    to_port = 5601
    protocol = "tcp"
    self = false
  }

  ingress {
    cidr_blocks = []
    from_port = -1
    to_port = -1
    protocol = "icmp"
    self = true
  }
}

