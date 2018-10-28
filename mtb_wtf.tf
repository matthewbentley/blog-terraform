resource "gandi_zone" "mtb_wtf" {
  name = "mtb.wtf zone"
}

resource "gandi_domainattachment" "mtb_wtf" {
  domain = "mtb.wtf"
  zone   = "${gandi_zone.mtb_wtf.id}"
}

module "fastmail_domain_mtb_wtf" "mtb_wtf" {
  source = "./fastmail_domain_gandi"
  domain = "mtb.wtf"
  zone   = "${gandi_zone.mtb_wtf.id}"
  caa    = ["letsencrypt.org"]
}

resource "gandi_zonerecord" "mtb_wtf_a" {
  zone = "${gandi_zone.mtb_wtf.id}"
  name = "@"
  type = "A"
  ttl  = "300"

  values = ["198.199.90.205"]
}

resource "gandi_zonerecord" "mtb_wtf_aaaa" {
  zone = "${gandi_zone.mtb_wtf.id}"
  name = "@"
  type = "AAAA"
  ttl  = "300"

  values = ["2604:a880:400:d0::a97:b001"]
}

resource "gandi_zonerecord" "mtb_wtf_icanhazip" {
  zone = "${gandi_zone.mtb_wtf.id}"
  name = "icanhazip"
  type = "CNAME"
  ttl  = "300"

  values = ["mtb.wtf."]
}

resource "gandi_zonerecord" "mtb_wtf_icanhazproxy" {
  zone = "${gandi_zone.mtb_wtf.id}"
  name = "icanhazproxy"
  type = "CNAME"
  ttl  = "300"

  values = ["mtb.wtf."]
}

resource "gandi_zonerecord" "mtb_wtf_icanhazepoch" {
  zone = "${gandi_zone.mtb_wtf.id}"
  name = "icanhazepoch"
  type = "CNAME"
  ttl  = "300"

  values = ["mtb.wtf."]
}

resource "gandi_zonerecord" "mtb_wtf_icanhazptr" {
  zone = "${gandi_zone.mtb_wtf.id}"
  name = "icanhazptr"
  type = "CNAME"
  ttl  = "300"

  values = ["mtb.wtf."]
}

resource "gandi_zonerecord" "mtb_wtf_icanhaztrace" {
  zone = "${gandi_zone.mtb_wtf.id}"
  name = "icanhaztrace"
  type = "CNAME"
  ttl  = "300"

  values = ["mtb.wtf."]
}

resource "gandi_zonerecord" "mtb_wtf_jump" {
  zone = "${gandi_zone.mtb_wtf.id}"
  name = "jump"
  type = "CNAME"
  ttl  = "300"

  values = ["people.acm.case.edu."]
}

resource "gandi_zonerecord" "kbp_mtb_wtf" {
  zone = "${gandi_zone.mtb_wtf.id}"
  name = "kbp"
  type = "CNAME"
  ttl  = "300"

  values = ["kbp.keybaseapi.com."]
}

resource "gandi_zonerecord" "bot_mtb_wtf" {
  zone = "${gandi_zone.mtb_wtf.id}"
  name = "bot"
  type = "CNAME"
  ttl  = "300"

  values = ["mtb.wtf."]
}

resource "gandi_zonerecord" "kbp_mtb_wtf_txt" {
  zone = "${gandi_zone.mtb_wtf.id}"
  name = "_keybase_pages.kbp"
  type = "TXT"
  ttl  = "300"

  values = ["\"kbp=/keybase/private/bentley,kbpbot/my-site\""]
}

resource "gandi_zonerecord" "bsd_mtb_wtf_a" {
  zone = "${gandi_zone.mtb_wtf.id}"
  name = "bsd"
  type = "A"
  ttl  = "300"

  values = ["104.248.4.245"]
}

resource "gandi_zonerecord" "ns1_mtb_wtf_a" {
  zone = "${gandi_zone.mtb_wtf.id}"
  name = "bsd"
  type = "A"
  ttl  = "300"

  values = ["104.248.4.245"]
}
