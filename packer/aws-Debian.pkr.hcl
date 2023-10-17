packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.0.0"
    }
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "source_ami" {
  type    = string
  default = "ami-06db4d78cb1d3bbf9"
}

variable "ssh_username" {
  type    = string
  default = "admin"
}

variable "subnet_id" {
  type    = string
  default = "subnet-0e2ecf06922ae0563"
}



source "amazon-ebs" "my-ami" {
  ami_name        = "Ami_1"
  ami_description = "First_AMI_Built_by_me"
  region          = "${var.aws_region}"
  profile         = "yuvaraj-dev"
  ami_users       = [245217519501, 940256833926]

  ami_regions = [
    "us-east-1",
  ]



  aws_polling {
    delay_seconds = 120
    max_attempts  = 50
  }

  instance_type = "t2.micro"
  source_ami    = "${var.source_ami}"
  ssh_username  = "${var.ssh_username}"
  subnet_id     = "${var.subnet_id}"

  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/xvdh"
    volume_size           = 8
    volume_type           = "gp2"
  }
}

build {
  sources = [
    "source.amazon-ebs.my-ami",
  ]

  provisioner "file" {
    source      = "web-app/Yuvaraj_dalavai_002789615_03.zip"
    destination = "/tmp/Yuvaraj_dalavai_002789615_03.zip"
  }

  provisioner "shell" {
    environment_vars = [
      "DEBIAN_FRONTEND= noninteractive",
      "CHECKPOINT_DISABLE=1"
    ]

    script = "./install.sh"

  }
}
