resource "aws_instance" "Narne" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name      = "terraform-key-pair"
  vpc_security_group_ids = ["${aws_security_group.webSG.id}"]

}
resource "null_resource" "website"{

  provisioner "file" {
    source      = "build"
    destination = "/tmp/build"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo rm /var/www/html/index.nginx-debian.html",
      "sudo cp -R /tmp/build/.* /var/www/html",  # Corrected the source directory path
      "sudo systemctl start nginx",  # Corrected the command to start nginx
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("terraform-key-pair.pem")
    timeout     = "4m"
    host        = aws_instance.Narne.public_ip
  }
}
resource "aws_security_group" "webSG" {
  name        = "webSG"
  description = "Allow ssh  inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]

  }
}


output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.Narne.public_ip
}
