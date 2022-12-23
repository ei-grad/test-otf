variable "provider_aws_assume_role_arn" {}

provider "aws" {
  assume_role {
    role_arn = var.provider_aws_assume_role_arn
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "test" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.nano"
}
