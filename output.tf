# My Output
output "front_domain" {
  value       = aws_cloudfront_distribution.s3_distribution.aliases
  description = "Frontend Website Domain"
}

