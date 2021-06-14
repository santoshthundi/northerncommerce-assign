
  
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

tags = {
  Name = "Custom VPC"
}
}

resource "aws_subnet" "bastion-subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.bastion-subnet
  map_public_ip_on_launch = true
  availability_zone = var.availability-zone

  tags = {
    Name = "bastion-subnet"
  }
}

resource "aws_subnet" "web-subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.web-subnet
  map_public_ip_on_launch = true
  availability_zone = var.availability-zone

  tags = {
    Name = "web-subnet"
  }
}

resource "aws_subnet" "app-subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.app-subnet
  map_public_ip_on_launch = true
  availability_zone = var.availability-zone

  tags = {
    Name = "app-subnet"
  }
}

resource "aws_security_group" "bastion-sg" {
 vpc_id = aws_vpc.main.id
 name = "Allow SSH Connection"
 description = "Allow SSH Inbound Trafic"

ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
}


resource "aws_key_pair" "ssh" {
  key_name = "ssh"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDJplW9aIawqmIHS8wIBBc61k+1I9KC0C+kL2jtY7K4veau3E95QhUcLLFfHb0E9PGstOFMv4HR1SSEwlOpD0oX++ZFhkd7TZ1Hy6q4vrQwY6OheVc/gYKwHdUCh533RrmEqwn41rVnqr9/OGCu8Avp3yiu3WBMyyYCQZlhvvw+oEUZ875xdqy/yrYvqC953pI8o2noIBv1DWzZbb1w7eWytuhfZyoHGERM4BZEjy6B6GTAnIVMu76rFPtypURW1gRaMUa64hmgHU+QyjIPYplU5Cw0kuGf9MoMoFJiumEqewUiyPA3pfo8yHIKSK0KKEm+o/iNWPCtiNt0aM/ERMF jayaprakash@DESKTOP-ND63NI2"
}

#Launching Bastion Instance
resource "aws_instance" "bastion-instance" {
  instance_type = var.instance
  ami = var.ami
  #associate_public_ip_address = true
  subnet_id = aws_subnet.bastion-subnet.id
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]
  key_name = "ssh"
tags = {
  Name = "bastion-instance"
}
}

#Launch Web Instance
resource "aws_instance" "web-instance" {
  instance_type = var.instance
  ami = var.ami
  subnet_id = aws_subnet.bastion-subnet.id
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]
  key_name = "ssh"

  tags = {
    Name = "web-instance"
  }
  provisioner "remote-exec" {
    inline =[
      "sudo apt-get install apache2 -y"
      "sudo apt-get install curl -y"
    ]

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("~/.ssh/final.pem")
      #private_key = "${file(./id_rsa)}"
      host = self.public_ip
      timeout = "3m"
    }
  }
}

#Launch app Instance
resource "aws_instance" "app-instance" {
  instance_type = var.instance
  ami = var.ami
  subnet_id = aws_subnet.app-subnet.id
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]
  key_name = "ssh"

  tags = {
    Name = "app-instance"
  }
  provisioner "remote-exec" {
    inline =[
      "sudo apt-get install apache2 -y"
      "sudo apt-get install curl -y"
    ]

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("~/.ssh/final.pem")
      #private_key = "${file(./id_rsa)}"
      host = self.public_ip
      timeout = "3m"
    }
  }
}

