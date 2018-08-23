
resource "aws_route53_zone" "mtb_wtf" {
  name = "mtb.wtf"
}

resource "namecheap_ns" "mtb_wtf" {
  domain  = "mtb.wtf"
  servers = ["${aws_route53_zone.mtb_wtf.name_servers}"]
}

module "fastmail_domain_mtb_wtf" "mtb_wtf" {
  source  = "./fastmail_domain"
  domain  = "mtb.wtf"
  zone_id = "${aws_route53_zone.mtb_wtf.zone_id}"
  caa     = ["letsencrypt.org"]
}

resource "aws_route53_record" "mtb_wtf_a" {
  zone_id = "${aws_route53_zone.mtb_wtf.zone_id}"
  name    = "mtb.wtf"
  type    = "A"
  ttl     = "300"

  records = ["198.199.90.205"]
}

resource "aws_route53_record" "mtb_wtf_aaaa" {
  zone_id = "${aws_route53_zone.mtb_wtf.zone_id}"
  name    = "mtb.wtf"
  type    = "AAAA"
  ttl     = "300"

  records = ["2604:a880:400:d0::a97:b001"]
}

resource "aws_route53_record" "mtb_wtf_icanhazip" {
  zone_id = "${aws_route53_zone.mtb_wtf.zone_id}"
  name    = "icanhazip.mtb.wtf"
  type    = "CNAME"
  ttl     = "300"

  records = ["mtb.wtf"]
}

resource "aws_route53_record" "mtb_wtf_icanhazproxy" {
  zone_id = "${aws_route53_zone.mtb_wtf.zone_id}"
  name    = "icanhazproxy.mtb.wtf"
  type    = "CNAME"
  ttl     = "300"

  records = ["mtb.wtf"]
}

resource "aws_route53_record" "mtb_wtf_icanhazepoch" {
  zone_id = "${aws_route53_zone.mtb_wtf.zone_id}"
  name    = "icanhazepoch.mtb.wtf"
  type    = "CNAME"
  ttl     = "300"

  records = ["mtb.wtf"]
}

resource "aws_route53_record" "mtb_wtf_icanhazptr" {
  zone_id = "${aws_route53_zone.mtb_wtf.zone_id}"
  name    = "icanhazptr.mtb.wtf"
  type    = "CNAME"
  ttl     = "300"

  records = ["mtb.wtf"]
}

resource "aws_route53_record" "mtb_wtf_icanhaztrace" {
  zone_id = "${aws_route53_zone.mtb_wtf.zone_id}"
  name    = "icanhaztrace.mtb.wtf"
  type    = "CNAME"
  ttl     = "300"

  records = ["mtb.wtf"]
}

resource "aws_route53_record" "mtb_wtf_jump" {
  zone_id = "${aws_route53_zone.mtb_wtf.zone_id}"
  name    = "jump.mtb.wtf"
  type    = "CNAME"
  ttl     = "300"

  records = ["people.acm.case.edu"]
}

resource "aws_route53_record" "kbp_mtb_wtf" {
  zone_id = "${aws_route53_zone.mtb_wtf.zone_id}"
  name    = "kbp.mtb.wtf"
  type    = "CNAME"
  ttl     = "300"

  records = ["kbp.keybaseapi.com"]
}

resource "aws_route53_record" "bot_mtb_wtf" {
  zone_id = "${aws_route53_zone.mtb_wtf.zone_id}"
  name    = "bot.mtb.wtf"
  type    = "CNAME"
  ttl     = "300"

  records = ["mtb.wtf"]
}

resource "aws_route53_record" "kbp_mtb_wtf_txt" {
  zone_id = "${aws_route53_zone.mtb_wtf.zone_id}"
  name    = "_keybase_pages.kbp.mtb.wtf"
  type    = "TXT"
  ttl     = "300"

  records = ["kbp=/keybase/private/bentley,kbpbot/my-site"]
}
