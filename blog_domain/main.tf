variable "cf_name" {}
variable "cf_zone_id" {}
variable "domain" {}
variable "zone_id" {}

resource "aws_route53_record" "a" {
  zone_id = "${var.zone_id}"
  name    = "${var.domain}"
  type    = "A"

  alias {
    name                   = "${var.cf_name}"
    zone_id                = "${var.cf_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "aaaa" {
  zone_id = "${var.zone_id}"
  name    = "${var.domain}"
  type    = "AAAA"

  alias {
    name                   = "${var.cf_name}"
    zone_id                = "${var.cf_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = "${var.zone_id}"
  name    = "www.${var.domain}"
  type    = "CNAME"
  ttl     = "300"

  records = ["${var.domain}"]
}
