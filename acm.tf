# Create a Domain ACM
resource "aws_acm_certificate" "certificate" {
  domain_name       = "*.${var.domain}"
  validation_method = "DNS"
  key_algorithm     = "RSA_2048"

  tags = local.common_tags

  lifecycle {
    create_before_destroy = true
  }
}

#############################################################
#############################################################

# Create a CNAME on Cloudflayr
data "cloudflare_zone" "site_domain" {
  name = var.domain
}

resource "cloudflare_record" "add_domain" {
  for_each = {
    for cert in aws_acm_certificate.certificate.domain_validation_options : cert.domain_name => {
      name   = cert.resource_record_name
      record = cert.resource_record_value
      type   = cert.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  value           = each.value.record
  type            = each.value.type
  zone_id         = data.cloudflare_zone.site_domain.zone_id
}