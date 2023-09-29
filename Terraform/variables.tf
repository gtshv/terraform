# variable "network_interface_id" {
#   type = string
#   default = "network_id_from_aws"
# }

variable "ami" {
  type    = string
  default = "ami-0a261c0e5f51090b1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}