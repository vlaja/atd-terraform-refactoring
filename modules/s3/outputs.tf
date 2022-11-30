output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}

output "bucket_id" {
  value = aws_s3_bucket.this.id
}

output "regional_domain_name" {
  value = aws_s3_bucket.this.bucket_regional_domain_name
}

output "s3_access_key" {
  value     = aws_iam_access_key.this.id
  sensitive = true
}

output "s3_access_secret" {
  value     = aws_iam_access_key.this.secret
  sensitive = true
}
