# Create S3 Bucket
resource "aws_s3_bucket" "bucket_name" {
  bucket        = local.perfix
  force_destroy = true
  tags          = local.common_tags

}

resource "aws_s3_bucket_ownership_controls" "owner" {
  bucket = aws_s3_bucket.bucket_name.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "versioning_front" {
  bucket = aws_s3_bucket.bucket_name.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.bucket_name.id

  rule {
    bucket_key_enabled = true
  }
}

#############################################################
#############################################################

# Access to s3 bucket from CloudFront
resource "aws_s3_bucket_policy" "access_cloudfront_to_s3_bucket" {
  bucket = aws_s3_bucket.bucket_name.id
  policy = data.aws_iam_policy_document.cloudfront_policy.json
}

data "aws_iam_policy_document" "cloudfront_policy" {
  version   = "2008-10-17"
  policy_id = "PolicyForCloudFrontPrivateContent"

  statement {
    sid    = "AllowCloudFrontServicePrincipal"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.bucket_name.arn}/*"]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = ["${aws_cloudfront_distribution.s3_distribution.arn}"]
    }
  }
}
