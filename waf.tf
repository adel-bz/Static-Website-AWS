# Create WAF Rule ("Request Rate Limits")
resource "aws_wafv2_web_acl" "acl" {
  name        = "limited-request"
  description = "Limited Request Per IP"
  scope       = "CLOUDFRONT"

  default_action {
    allow {} # pass traffic until the rules trigger a block
  }

  rule {
    name     = "limited-request"
    priority = 0

    action {
      block {}
    }
    statement {
      rate_based_statement {
        limit              = 500
        aggregate_key_type = "IP"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "limited-request"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "limited-request"
    sampled_requests_enabled   = true
  }
}