data "aws_route53_zone" "zone" {
  name = "${var.domain}"
}

resource "aws_route53_record" "alias_route53_record" {
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  name    = "${var.domain}"
  type    = "A"

  alias {
    name                   = "${aws_alb.main.dns_name}"
    zone_id                = "${aws_alb.main.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www_route53_record" {
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  name    = format("www.%s","${var.domain}")
  type    = "CNAME"
  records = ["${aws_cloudfront_distribution.elb_distribution.domain_name}"]
  ttl = "300"
}
