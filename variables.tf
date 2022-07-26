variable "vpc" {
  type    = string
  default = "vpc-086453d067f73b0d7"
}

variable "subnet" {
  type    = string
  default = "subnet-0918b0e94064c3f60"
}

variable "publicip" {
  type    = bool
  default = true
}

variable "security_group" {
  type    = string
  default = "Devops-Sec-Group"
}

variable "keyname" {
  type    = string
  default = "server-secret"
}

variable "ami" {
  type    = string
  default = "ami-052efd3df9dad4825"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

provider "aws" {}
