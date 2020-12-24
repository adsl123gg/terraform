locals {
  bucket_name = "${var.bucket}-${var.env}"
}

resource "aws_s3_bucket" "bucket" {
  bucket = local.bucket_name 

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "resources" {
  bucket     = local.bucket_name
  key        = "resources/"
  depends_on = [aws_s3_bucket.bucket]
}

