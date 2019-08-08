variable "domain" {}

variable "zone_id" {}

variable "caa" {
  type    = "list"
  default = ["amazon.com"]
}

variable "caa_email" {
  default = "caa@matthew.bentley.link"
}

resource "aws_route53_record" "mx" {
  zone_id = "${var.zone_id}"
  name    = "${var.domain}"
  type    = "MX"
  ttl     = "300"

  records = ["10 in1-smtp.messagingengine.com.", "20 in2-smtp.messagingengine.com."]
}

resource "aws_route53_record" "txt" {
  zone_id = "${var.zone_id}"
  name    = "${var.domain}"
  type    = "TXT"
  ttl     = "300"

  records = ["v=spf1 include:spf.messagingengine.com ?all"]
}

resource "aws_route53_record" "star_mx" {
  zone_id = "${var.zone_id}"
  name    = "*.${var.domain}"
  type    = "MX"
  ttl     = "300"

  records = ["10 in1-smtp.messagingengine.com.", "20 in2-smtp.messagingengine.com."]
}

resource "aws_route53_record" "fm1" {
  zone_id = "${var.zone_id}"
  name    = "fm1._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = "300"

  records = ["fm1.${var.domain}.dkim.fmhosted.com."]
}

resource "aws_route53_record" "fm2" {
  zone_id = "${var.zone_id}"
  name    = "fm2._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = "300"

  records = ["fm2.${var.domain}.dkim.fmhosted.com."]
}

resource "aws_route53_record" "fm3" {
  zone_id = "${var.zone_id}"
  name    = "fm3._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = "300"

  records = ["fm3.${var.domain}.dkim.fmhosted.com."]
}

resource "aws_route53_record" "mesmtp" {
  zone_id = "${var.zone_id}"
  name    = "mesmtp._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = "300"

  records = ["mesmtp.${var.domain}.dkim.fmhosted.com."]
}

resource "aws_route53_record" "caldav" {
  zone_id = "${var.zone_id}"
  name    = "_caldav._tcp.${var.domain}"
  type    = "SRV"
  ttl     = "300"

  records = ["0 0 0 ."]
}

resource "aws_route53_record" "caldavs" {
  zone_id = "${var.zone_id}"
  name    = "_caldavs._tcp.${var.domain}"
  type    = "SRV"
  ttl     = "300"

  records = ["0 1 443 caldav.fastmail.com"]
}

resource "aws_route53_record" "carddav" {
  zone_id = "${var.zone_id}"
  name    = "_carddav._tcp.${var.domain}"
  type    = "SRV"
  ttl     = "300"

  records = ["0 0 0 ."]
}

resource "aws_route53_record" "carddavs" {
  zone_id = "${var.zone_id}"
  name    = "_carddavs._tcp.${var.domain}"
  type    = "SRV"
  ttl     = "300"

  records = ["0 1 443 carddav.fastmail.com"]
}

resource "aws_route53_record" "imap" {
  zone_id = "${var.zone_id}"
  name    = "_imap._tcp.${var.domain}"
  type    = "SRV"
  ttl     = "300"

  records = ["0 0 0 ."]
}

resource "aws_route53_record" "imaps" {
  zone_id = "${var.zone_id}"
  name    = "_imaps._tcp.${var.domain}"
  type    = "SRV"
  ttl     = "300"

  records = ["0 1 993 imap.fastmail.com"]
}

resource "aws_route53_record" "pop3" {
  zone_id = "${var.zone_id}"
  name    = "_pop3._tcp.${var.domain}"
  type    = "SRV"
  ttl     = "300"

  records = ["0 0 0 ."]
}

resource "aws_route53_record" "pop3s" {
  zone_id = "${var.zone_id}"
  name    = "_pop3s._tcp.${var.domain}"
  type    = "SRV"
  ttl     = "300"

  records = ["10 1 995 pop.fastmail.com"]
}

resource "aws_route53_record" "submission" {
  zone_id = "${var.zone_id}"
  name    = "_submission._tcp.${var.domain}"
  type    = "SRV"
  ttl     = "300"

  records = ["0 1 587 smtp.fastmail.com"]
}

resource "null_resource" "caas" {
  count = "${length(var.caa)}"

  triggers = {
    caa      = "0 issue \"${element(var.caa, count.index)}\""
    caa_wild = "0 issuewild \"${element(var.caa, count.index)}\""
  }
}

resource "aws_route53_record" "caa" {
  zone_id = "${var.zone_id}"
  name    = "${var.domain}"
  type    = "CAA"
  ttl     = "300"

  records = concat(null_resource.caas.*.triggers.caa, null_resource.caas.*.triggers.caa_wild, list("0 iodef \"mailto:${var.caa_email}\""))
}
