resource "aws_s3_bucket_object" "index" {
  bucket       = aws_s3_bucket.b.id
  key          = "index.html"
  source       = "${path.module}/files/index.html"
  content_type = "text/html"
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_s3_bucket_object" "error" {
  bucket       = aws_s3_bucket.b.id
  key          = "404.html"
  source       = "${path.module}/files/404.html"
  content_type = "text/html"
  lifecycle {
    ignore_changes = all
  }
}
