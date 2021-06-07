data "aws_route53_zone" "home" {
  name = "matiu.dev"
}

resource "aws_route53_record" "web1" {
  zone_id = data.aws_route53_zone.home.id
  type    = "A"
  name    = var.dns_prefix
  ttl     = 300
  records = [aws_instance.sysops_study.public_ip]
}
