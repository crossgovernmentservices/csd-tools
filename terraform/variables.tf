variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.

Example: ~/.ssh/terraform.pub
DESCRIPTION
}

variable "key_name" {
  description = "Desired name of AWS key pair"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default = "eu-west-1"
}

# Ubuntu Precise 14.04 LTS (x64) HVM
variable "aws_amis" {
  default = {
    eu-west-1 = "ami-f95ef58a"
    eu-central-1 = "ami-87564feb"
  }
}

variable "r53_main_zone_id" {
  description = "Main parent DNS zone ID in R53"
}

variable "r53_tools_zone_name" {
    description = "DNS zone for 'tools' services"
}
