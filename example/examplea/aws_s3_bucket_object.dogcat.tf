


resource "aws_s3_bucket_object" "cat" {
  #checkov:skip=CKV_AWS_186:
  bucket       = aws_s3_bucket.routed.id
  key          = "path1/cat.jpg"
  source       = "${path.module}/files/path1/cat.jpg"
  content_type = "jpg"
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_s3_bucket_object" "dog" {
  #checkov:skip=CKV_AWS_186:
  bucket       = aws_s3_bucket.routed.id
  key          = "path2/dog.jpg"
  source       = "${path.module}/files/path2/dog.jpg"
  content_type = "jpg"
  lifecycle {
    ignore_changes = all
  }
}
