resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket
  versioning {
    enabled = true
  }

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket     = var.bucket
  key        = var.tfkey
  depends_on = [aws_s3_bucket.bucket]
}

resource "aws_s3_bucket_object" "resources" {
  bucket     = var.bucket
  key        = "resources/"
  acl        = "public-read"
  depends_on = [aws_s3_bucket.bucket]
}

