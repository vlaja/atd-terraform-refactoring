data "aws_iam_policy_document" "this" {
  statement {
    sid = "ListBucket"

    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.this.arn]
    }

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = [
      aws_s3_bucket.this.arn,
    ]
  }

  statement {
    sid = "ManageBucketObjects"

    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.this.arn]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:DeleteObject"
    ]

    resources = [
      "${aws_s3_bucket.this.arn}/*",
    ]
  }

  statement {
    sid = "CloudflarePublicGet"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values = [
        # Cloudflare IPs
        "173.245.48.0/20",
        "103.21.244.0/22",
        "103.22.200.0/22",
        "103.31.4.0/22",
        "141.101.64.0/18",
        "108.162.192.0/18",
        "190.93.240.0/20",
        "188.114.96.0/20",
        "197.234.240.0/22",
        "198.41.128.0/17",
        "162.158.0.0/15",
        "104.16.0.0/13",
        "104.24.0.0/14",
        "172.64.0.0/13",
        "131.0.72.0/22"
      ]
    }

    resources = [
      "${aws_s3_bucket.this.arn}/*",
    ]
  }

  dynamic "statement" {
    for_each = var.cloudfront_origin_access_identity_arn != "" ? [1] : []

    content {
      sid = "CloudFrontOriginAccessIdentityRead"

      principals {
        type        = "AWS"
        identifiers = [var.cloudfront_origin_access_identity_arn]
      }

      actions = [
        "s3:GetObject",
      ]

      resources = [
        "${aws_s3_bucket.this.arn}/*",
      ]
    }
  }
}
