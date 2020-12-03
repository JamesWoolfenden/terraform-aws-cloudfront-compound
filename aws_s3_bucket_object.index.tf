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


resource "aws_s3_bucket_object" "cat" {
  bucket       = aws_s3_bucket.routed.id
  key          = "path1/cat.jpg"
  source       = "${path.module}/files/path1/cat.jpg"
  content_type = "jpg"
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_s3_bucket_object" "dog" {
  bucket       = aws_s3_bucket.routed.id
  key          = "path2/dog.jpg"
  source       = "${path.module}/files/path2/dog.jpg"
  content_type = "jpg"
  lifecycle {
    ignore_changes = all
  }
}
