output "load_balancer_endpoint" {
  value = "${aws_alb.main.dns_name}"
}

output "cloudfront_endpoint" {
  value = "${aws_cloudfront_distribution.elb_distribution.domain_name}"
}

output "url_that_uses_load_balancer_endpoint" {
  value = format("http://%s","${var.domain}")
}

output "url_that_uses_cloudfront_endpoint" {
  value = format("http://www.%s","${var.domain}")
}
