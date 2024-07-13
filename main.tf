resource "aws_s3_bucket" "mybucketstatic" {
  bucket = var.bucket_name

  tags = var.tags
  
}

resource "aws_s3_bucket_ownership_controls" "s3_ownership" {
  bucket = aws_s3_bucket.mybucketstatic.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_public" {
  bucket = aws_s3_bucket.mybucketstatic.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "mybucketstatic" {
  depends_on = [aws_s3_bucket_ownership_controls.s3_ownership]

  bucket = aws_s3_bucket.mybucketstatic.id
  acl    = "public-read"
}



resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.mybucketstatic.id
  key    = "index.html"
  source = "index.html"
  acl = "public-read"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "error" {
  bucket = aws_s3_bucket.mybucketstatic.id
  key    = "error.html"
  source = "error.html"
  acl = "public-read"
  content_type = "text/error"
}

resource "aws_s3_bucket_object" "central-park" {
  bucket = aws_s3_bucket.mybucketstatic.id
  key    = "central-park.jpg"
  source = "central-park.jpg"
  acl = "public-read"

}
resource "aws_s3_bucket_object" "statue-of-liberty" {
  bucket = aws_s3_bucket.mybucketstatic.id
  key    = "statue-of-liberty.jpg"
  source = "statue-of-liberty.jpg"
  acl = "public-read"

}
resource "aws_s3_bucket_object" "times-square" {
  bucket = aws_s3_bucket.mybucketstatic.id
  key    = "times-square.jpg"
  source = "times-square.jpg"
  acl = "public-read"

}


resource "aws_s3_bucket_website_configuration" "s3_config" {
  bucket = aws_s3_bucket.mybucketstatic.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
  depends_on = [ aws_s3_bucket_acl.mybucketstatic ]

}






