variable "domain" {}

variable "zone" {}

variable "caa" {
type    = "list"
default = ["amazon.com"]
}

variable "caa_email" {
default = "caa@matthew.bentley.link"
}

resource "gandi_zonerecord" "mx" {
zone = "${var.zone}"
name = "${var.domain}"
type = "MX"
ttl  = "300"

values = ["10 in1-smtp.messagingengine.com.", "20 in2-smtp.messagingengine.com."]
}

resource "gandi_zonerecord" "txt" {
zone = "${var.zone}"
name = "${var.domain}"
type = "TXT"
ttl  = "300"

values = ["\"v=spf1 include:spf.messagingengine.com ?all\""]
}

resource "gandi_zonerecord" "star_mx" {
  zone = "${var.zone}"
  name = "*.${var.domain}"
  type = "MX"
  ttl  = "300"

  values = ["10 in1-smtp.messagingengine.com.", "20 in2-smtp.messagingengine.com."]
}

resource "gandi_zonerecord" "fm1" {
  zone = "${var.zone}"
  name = "fm1._domainkey.${var.domain}"
  type = "CNAME"
  ttl  = "300"

  values = ["fm1.${var.domain}.dkim.fmhosted.com."]
}

resource "gandi_zonerecord" "fm2" {
  zone = "${var.zone}"
  name = "fm2._domainkey.${var.domain}"
  type = "CNAME"
  ttl  = "300"

  values = ["fm2.${var.domain}.dkim.fmhosted.com."]
}

resource "gandi_zonerecord" "fm3" {
  zone = "${var.zone}"
  name = "fm3._domainkey.${var.domain}"
  type = "CNAME"
  ttl  = "300"

  values = ["fm3.${var.domain}.dkim.fmhosted.com."]
}

resource "gandi_zonerecord" "mesmtp" {
  zone = "${var.zone}"
  name = "mesmtp._domainkey.${var.domain}"
  type = "CNAME"
  ttl  = "300"

  values = ["mesmtp.${var.domain}.dkim.fmhosted.com."]
}

resource "gandi_zonerecord" "caldav" {
  zone = "${var.zone}"
  name = "_caldav._tcp.${var.domain}"
  type = "SRV"
  ttl  = "300"

  values = ["0 0 0 ."]
}

resource "gandi_zonerecord" "caldavs" {
  zone = "${var.zone}"
  name = "_caldavs._tcp.${var.domain}"
  type = "SRV"
  ttl  = "300"

  values = ["0 1 443 caldav.fastmail.com"]
}

resource "gandi_zonerecord" "carddav" {
  zone = "${var.zone}"
  name = "_carddav._tcp.${var.domain}"
  type = "SRV"
  ttl  = "300"

  values = ["0 0 0 ."]
}

resource "gandi_zonerecord" "carddavs" {
  zone = "${var.zone}"
  name = "_carddavs._tcp.${var.domain}"
  type = "SRV"
  ttl  = "300"

  values = ["0 1 443 carddav.fastmail.com"]
}

resource "gandi_zonerecord" "imap" {
  zone = "${var.zone}"
  name = "_imap._tcp.${var.domain}"
  type = "SRV"
  ttl  = "300"

  values = ["0 0 0 ."]
}

resource "gandi_zonerecord" "imaps" {
  zone = "${var.zone}"
  name = "_imaps._tcp.${var.domain}"
  type = "SRV"
  ttl  = "300"

  values = ["0 1 993 imap.fastmail.com"]
}

resource "gandi_zonerecord" "pop3" {
  zone = "${var.zone}"
  name = "_pop3._tcp.${var.domain}"
  type = "SRV"
  ttl  = "300"

  values = ["0 0 0 ."]
}

resource "gandi_zonerecord" "pop3s" {
  zone = "${var.zone}"
  name = "_pop3s._tcp.${var.domain}"
  type = "SRV"
  ttl  = "300"

  values = ["10 1 995 pop.fastmail.com"]
}

resource "gandi_zonerecord" "submission" {
  zone = "${var.zone}"
  name = "_submission._tcp.${var.domain}"
  type = "SRV"
  ttl  = "300"

  values = ["0 1 587 smtp.fastmail.com"]
}

resource "null_resource" "caas" {
  count = "${length(var.caa)}"

  triggers = {
    caa      = "0 issue \"${element(var.caa, count.index)}\""
    caa_wild = "0 issuewild \"${element(var.caa, count.index)}\""
  }
}

resource "gandi_zonerecord" "caa" {
  zone = "${var.zone}"
  name = "${var.domain}"
  type = "CAA"
  ttl  = "300"

  values = ["${concat(null_resource.caas.*.triggers.caa, null_resource.caas.*.triggers.caa_wild, list("0 iodef \"mailto:${var.caa_email}\""))}"]
}
