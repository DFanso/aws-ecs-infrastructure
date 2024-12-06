# Create an SSL certificate
resource "aws_acm_certificate" "main" {
  domain_name       = "*.${var.domain_name}"
  validation_method = "DNS"

  subject_alternative_names = [var.domain_name]

  lifecycle {
    create_before_destroy = true
  }
}

# Get the Cloudflare zone
data "cloudflare_zone" "main" {
  name = var.domain_name
}

# Create DNS records for certificate validation
resource "cloudflare_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
      name   = trimsuffix(dvo.resource_record_name, ".")
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = data.cloudflare_zone.main.id
  name    = replace(each.value.name, ".${var.domain_name}", "")
  content = each.value.record
  type    = each.value.type
  proxied = false
  ttl     = 60

  allow_overwrite = true

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      name,
      content
    ]
  }
}

# Validate the certificate
resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in cloudflare_record.cert_validation : record.hostname]

  lifecycle {
    create_before_destroy = true
  }
}
