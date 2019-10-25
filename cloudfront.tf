resource "aws_cloudfront_distribution" "elb_distribution" {
  origin {
    domain_name = "${aws_alb.main.dns_name}"
    origin_id   = format("ELB-%s", element(split(".", "${aws_alb.main.dns_name}"), 0))

    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols = ["TLSv1","TLSv1.1","TLSv1.2"]
    }
  }

  enabled = true

  aliases = [format("www.%s","${var.domain}")]


  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = format("ELB-%s", element(split(".", "${aws_alb.main.dns_name}"), 0))


    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    acm_certificate_arn = "${var.ssl_certificate_arn}"
    ssl_support_method = "sni-only"
  }

}
