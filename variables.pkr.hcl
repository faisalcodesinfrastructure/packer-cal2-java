################################################################################
# AWS Specific
variable "aws_region" {
  type        = string
  description = "AWS Region in which to build image."
  default     = "us-east-1"
}

variable "aws_instance_type" {
  type        = string
  description = "Instance on which to build image."
  default     = "t2.micro"
}

variable "encrypt_boot" {
  type        = bool
  description = "Encrypt boot volume?"
  default     = false
}

variable "aws_kms_key_id" {
  type        = string
  description = "ARN for KMS Key ID to use for encrypting volume."
  default     = ""
}

variable "amazon_communicator" {
  type        = string
  description = "Communicator for Amazon builder."
  default     = "ssh"
}

variable "amazon_ssh_username" {
  type        = string
  description = "SSH username for Amazon builder."
  default     = "ec2-user"
}

variable "amazon_image_name" {
  type        = string
  description = "Value to use for naming Amazon image."
  default     = "Java Golden Image - CIS Amazon Linux 2 Bechmark v2 - Level 2"
}

################################################################################

variable "prefix" {
  type        = string
  description = "Prefix for naming image"
  default     = "cis-amazon-linux-2"
}

variable "owner" {
  type        = string
  description = "The person or group who launched these resources.  Must be a valid HashiCorp email prefix."
}

variable "ttl" {
  type        = string
  description = "Time in hours from the launch that a resource can be stopped/terminated. Use -1 for permanent resources."
  default     = "-1"
}

variable "config-as-code" {
  type        = string
  description = "Config-as-code tool used to provision this image."
  default     = "packer"
}

variable "repo" {
  type        = string
  description = "If a config-as-code value is set, the repository that holds the code used to create this resource."
  default     = ""
}

################################################################################
# HCP Packer

variable "bucket_name" {
  type        = string
  description = "The image name when published to the HCP Packer registry. Will be overwritten if HCP_PACKER_BUCKET_NAME is set."
}

variable "bucket_description" {
  type        = string
  description = "The image description. Useful to provide a summary about the image. The description will appear at the image's main page and will be updated whenever it is changed and a new build is pushed to the HCP Packer registry. Should contain a maximum of 255 characters."
  default     = ""
}

variable "base_image_bucket_name" {
  type        = string
  description = "The name of the channel to use when retrieving your image."
}

variable "base_image_channel" {
  type        = string
  description = "The name of the channel to use when retrieving your image."
}
