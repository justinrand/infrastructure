terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
  
}

variable "ssh_key_private" {
  default = "/data/config/deployment.key"
}

resource "aws_key_pair" "admin_key" {
  key_name = "admin_key"
  public_key = file("/data/config/deployment.key.pub")
}


resource "aws_instance" "elastic2" {
  ami           = "ami-03657b56516ab7912"
  instance_type = "t2.micro"
  key_name = "admin_key"
  availability_zone = "us-east-2b"
  user_data = "#!/bin/bash\nmkdir /usr/local/share/applications; mount -t ext4 /dev/xvdf /usr/local/share/applications;"
  vpc_security_group_ids = [aws_security_group.elastic2.id, aws_security_group.web443.id]

  provisioner "remote-exec" {
    inline = [
      "sudo yum -qq install python pip telnet -y"
    ]
  }
  
  # provisioner "local-exec" {
    # command = "ansible-playbook -i '${self.public_ip},' ../ansible/playbooks/base.yml"
  # }

  connection {
    type = "ssh"
    user = "ec2-user"
    host = self.public_ip
    private_key = file("/data/config/deployment.key")
  }
}

resource "aws_instance" "elastic" {
  ami           = "ami-03657b56516ab7912"
  instance_type = "t2.micro"
  key_name = "admin_key"
  availability_zone = "us-east-2b"
  user_data = "#!/bin/bash\nmkdir /usr/local/share/applications; mount -t ext4 /dev/xvdf /usr/local/share/applications;"
  vpc_security_group_ids = [aws_security_group.elastic2.id, aws_security_group.web443.id]

  provisioner "remote-exec" {
    inline = [
      "sudo yum -qq install python pip telnet -y"
    ]
  }
  connection {
    type = "ssh"
    user = "ec2-user"
    host = self.public_ip
    private_key = file("/data/config/deployment.key")
  }
}

# 