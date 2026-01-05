resource "aws_route53_record" "cert_validation_record" {
  name    = tolist(aws_acm_certificate.tfe.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.tfe.domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.tfe.domain_validation_options)[0].resource_record_value]
  zone_id = data.aws_route53_zone.tfe.zone_id
  ttl     = 60
}

resource "aws_route53_record" "tfe" {
  name    = local.route53_alias_record_name
  zone_id = data.aws_route53_zone.tfe.zone_id
  type    = "A"

  alias {
    name                   = module.alb.alb_dns_name
    zone_id                = module.alb.alb_zone_id
    evaluate_target_health = false
  }

  depends_on = [module.alb]
}
