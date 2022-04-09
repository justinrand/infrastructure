variable "ami_id" {
    default = "ami-03a9ac35e94b22002"
}

variable "elastic_instance_type" {
    default = "t2.micro"
}

variable "availability_zone" {
    default = "us-east-2b"
}

variable "region" {
    default = "us-east-2"
}

variable "ssh_key_private" {
  default = "/data/config/deployment.key"
}
