resource "aws_s3_object" "index" {
  #checkov:skip=CKV_AWS_186:
  bucket       = aws_s3_bucket.b.id
  key          = "index.html"
  source       = "${path.module}/files/index.html"
  content_type = "text/html"
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_s3_object" "error" {
  #checkov:skip=CKV_AWS_186:
  bucket       = aws_s3_bucket.b.id
  key          = "404.html"
  source       = "${path.module}/files/404.html"
  content_type = "text/html"
  lifecycle {
    ignore_changes = all
  }
}
