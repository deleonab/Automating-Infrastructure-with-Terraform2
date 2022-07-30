resource "aws_acm_certificate" "workachoo" {
  domain_name       = "workachoo.com"
  validation_method = "DNS"

  tags = {
    Environment = "dev"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_zone" "workachoo" {
  name = "workachoo.com"
  private_zone = false
}

