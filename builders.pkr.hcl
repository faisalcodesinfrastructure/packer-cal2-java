packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  encrypted = var.encrypt_boot && var.aws_kms_key_id != "" ? "encrypted-" : ""
}

data "hcp-packer-iteration" "iteration" {
  bucket_name = var.base_image_bucket_name
  channel     = var.base_image_channel
}

data "hcp-packer-image" "image-east" {
  bucket_name    = var.base_image_bucket_name
  iteration_id   = data.hcp-packer-iteration.iteration.id
  cloud_provider = "aws"
  region         = var.aws_region
}

source "amazon-ebs" "base_image" {
  source_ami    = data.hcp-packer-image.image-east.id
  ami_name      = "${var.prefix}-${local.encrypted}{{timestamp}}"
  region        = var.aws_region
  instance_type = var.aws_instance_type
  encrypt_boot  = var.encrypt_boot
  kms_key_id    = var.encrypt_boot ? var.aws_kms_key_id : ""
  communicator  = var.amazon_communicator
  ssh_username  = var.amazon_ssh_username

  tags = {
    Name           = "${var.amazon_image_name} - ${var.owner} {{timestamp}}"
    owner          = var.owner
    ttl            = var.ttl
    config-as-code = var.config-as-code
    repo           = var.repo
  }
}

build {
  hcp_packer_registry {
    bucket_name = var.bucket_name
    description = var.bucket_description

    bucket_labels = {
      "os"  = "linux"
      "foo" = "bar"
    }

    build_labels = {
      "build-time" = timestamp()
    }
  }

  sources = [
    "source.amazon-ebs.base_image"
  ]

  ## via shell provisioner
  #  provisioner "shell" {
  #    execute_command = "{{.Vars}} bash '{{.Path}}'"
  #    inline = [
  #      "sudo yum update -y",
  #      "sudo yum install -y yum-utils",
  #      "sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo",
  #      "sudo yum -y install terraform vault-enterprise consul-enterprise nomad-enterprise packer consul-template"
  #    ]
  #  }

  provisioner "ansible" {
    playbook_file = "./java.yaml"
  }
}
