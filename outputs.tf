output "instance_id" {
  value = aws_instance.sysops_study.id
}

output "instance_dns_name" {
  value = aws_instance.sysops_study.public_dns
}

output "short_dns" {
  value = "${aws_route53_record.web1.name}.${data.aws_route53_zone.home.name}"
}
