variable "access_key" {
  default = "AKIAY64JTYIGDUCKLQK2"
}

variable "secret_key" {
  default = "aPYb2zTR1ZO6vC30HmEVjiYGpyX12k+yJVWBBXQP"
}

variable "region" {
  default = "us-east-1"
}

variable "cidr_block" {
  default = "10.0.0.0/26"
}

variable "tags" {
  default = "Custom-VPC"
}

variable "bastion-subnet" {
  default = "10.0.0.0/28"
}

variable "web-subnet" {
  default = "10.0.0.16/28"
}

variable "app-subnet" {
  default = "10.0.0.32/28"
}

variable "availability-zone" {
  default = "us-east-1a"
}

variable "instance" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-0885b1f6bd170450c"
}
