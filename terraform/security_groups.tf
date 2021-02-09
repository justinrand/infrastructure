resource "aws_security_group" "web_from_alb" {
  name = "web_from_alb"  

  ingress {
    security_groups = [aws_security_group.loadbalancer_web.id]
    from_port = 443
    to_port = 443
    protocol = "tcp"
    description = "https from ALB"
  }

  ingress {
    security_groups = [aws_security_group.loadbalancer_web.id]
    from_port = 80
    to_port = 80
    protocol = "tcp"
    description = "http from ALB"
  }

  tags = {
    "Name" = "web_from_alb"
  }
}

resource "aws_security_group" "loadbalancer_web" {
  name = "loadbalancer_web"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port =  80
    to_port = 80
    protocol = "tcp"
    description = "http from anywhere"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 443
    to_port = 443
    protocol = "tcp"
    description = "https from anywhere"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
    description = "allow all traffic"
  }

  tags = {
    "Name" = "loadbalancer_web"
  }
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  ingress {
    cidr_blocks = ["96.255.42.144/32"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
    self = true
  }

  tags = {
    "Name" = "allow_ssh"
  }
}

resource "aws_security_group" "all_personal_traffic" {
  name = "all_personal_traffic"
  ingress {
    cidr_blocks = ["96.255.42.144/32"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }

  tags = {
    "Name" = "all_personal_traffic"
  }
}

resource "aws_security_group" "elastic" {
  name = "elastic"
  ingress {
    cidr_blocks = ["172.31.0.0/16"]
    from_port = 9200
    to_port = 9200
    protocol = "tcp"
    self = true
  }

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
    from_port = 5601
    to_port = 5601
    protocol = "tcp"
    self = false
  }

  tags = {
    "Name" = "elastic"
  }
}

