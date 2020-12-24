resource "aws_eip" "ip" {
  vpc      = true
  tags = {
    Name = "eip-${var.env}"
  }
}
