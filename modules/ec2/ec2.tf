resource "aws_instance" "example" {
  ami           = "ami-0e1ce3e0deb8896d2"
  instance_type = "t2.micro"
  key_name      = "aws_ubuntu_keypair"
  tags = {
    Name = "ubuntu"
  }
}

resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.example.id
}

output "ip" {
  value = aws_eip.ip.public_ip
}
output "ub_id" {
  value = aws_instance.example.id
}
output "ami_id" {
  value = aws_instance.example.ami
}

