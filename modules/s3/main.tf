resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Name      = var.bucket_name
    Namespace = var.namespace
  }
}

resource "aws_iam_user" "this" {
  name = "${var.bucket_name}-user"

}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

resource "aws_iam_user_policy" "objects" {
  name = "${var.bucket_name}-object-policy"
  user = aws_iam_user.this.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" = "Allow",
        "Action" = [
          "s3:GetBucketLocation",
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:GetObject",
          "s3:GetObjectAcl",
          "s3:GetObjectVersion",
          "s3:DeleteObject",
          "s3:DeleteObjectVersion"
        ],
        "Resource" = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}

resource "aws_iam_user_policy" "list_all_buckets" {
  name = "${var.bucket_name}-list-buckets-policy"
  user = aws_iam_user.this.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" = "Allow",
        "Action" = [
          "s3:ListAllMyBuckets",
        ],
        "Resource" = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy" "list_bucket" {
  name = "${var.bucket_name}-list-bucket-policy"
  user = aws_iam_user.this.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" = "Allow",
        "Action" = [
          "s3:GetBucketLocation",
          "s3:ListBucket",
        ],
        "Resource" = "${aws_s3_bucket.this.arn}"
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "this" {
  bucket = var.bucket_name
  policy = data.aws_iam_policy_document.this.json
}

