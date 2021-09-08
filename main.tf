terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-011996ff98de391d1"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-0e6b8932c0c31a533"]
  subnet_id = "subnet-063d896542a91351d"
  key_name = "Albert09032021"

  tags = {
    Name = var.instance_name
  }
}
