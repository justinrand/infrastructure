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

