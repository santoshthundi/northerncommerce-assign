provider "aws" {
  region = "us-east-2"
}
resource "aws_instance" "example" {
  ami           = "ami-07c1207a9d40bc3bd"
  instance_type = "t2.micro"
  count         = "${var.instance_count}"
  key_name      = "AWSnew"
   provisioner "file" {
    source      = "/root/terraformcode/nginx.sh"
    destination = "/tmp/nginx.sh"
  }
  # Change permissions on bash script and execute from ec2-user.
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/nginx.sh",
      "sudo /tmp/nginx.sh '${var.index_message}'",
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = file("/root/terraformcode/aws.pem")
    host        = self.public_ip
  }

  tags = {
    Name = "terraform-ec2"
  }
}

