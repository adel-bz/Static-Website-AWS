# Create a CloudFront distribution
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.bucket_name.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.s3_origin_access.id
    origin_id                = aws_s3_bucket.bucket_name.bucket_regional_domain_name
    origin_shield {
      enabled              = true
      origin_shield_region = var.region
    }
  }
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Front S3 Distributions"
  default_root_object = "index.html"
  aliases             = ["${var.sub_domain}.${var.domain}"] #if you want to website just open on root domain, just use "var.domain" and delete "var.subdomain" and ".". 
  #it will be: aliases = [var.domain]
  http_version = "http2and3"

  default_cache_behavior {
    allowed_methods            = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods             = ["GET", "HEAD"]
    cache_policy_id            = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    target_origin_id           = aws_s3_bucket.bucket_name.bucket_regional_domain_name
    viewer_protocol_policy     = "redirect-to-https"
    compress                   = true
    response_headers_policy_id = aws_cloudfront_response_headers_policy.security_headers.id
  }
  web_acl_id  = aws_wafv2_web_acl.acl.arn
  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.certificate.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

  tags = local.common_tags
}

resource "aws_cloudfront_origin_access_control" "s3_origin_access" {
  name                              = aws_s3_bucket.bucket_name.bucket_regional_domain_name
  description                       = "Access to ${local.perfix}-front S3 Bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
resource "aws_cloudfront_response_headers_policy" "security_headers" {
  name    = "CustomSecurityHeadersPolicy"
  comment = "My Custom Security Headers Policy For Website"

  security_headers_config {

    strict_transport_security {
      access_control_max_age_sec = "31536000"
      include_subdomains         = true
      preload                    = false
      override                   = true
    }
    content_type_options {
      override = true
    }
    frame_options {
      frame_option = "SAMEORIGIN"
      override     = true
    }
    referrer_policy {
      referrer_policy = "strict-origin-when-cross-origin"
      override        = true
    }

  }
}

#############################################################
#############################################################

# Add CloudFront domain as a CNAME to Cloudflare
resource "cloudflare_record" "add_cloudfront_domain" {
  zone_id = data.cloudflare_zone.site_domain.zone_id
  name    = var.sub_domain #if you want to website just open on the root domain, replace "var.subdomain" with "var.domain"
  value   = aws_cloudfront_distribution.s3_distribution.domain_name
  type    = "CNAME"
}
