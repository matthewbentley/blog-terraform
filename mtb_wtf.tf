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
  name = "ns1"
  type = "A"
  ttl  = "300"

  values = ["104.248.4.245"]
}

resource "gandi_zonerecord" "bsd_mtb_wtf_sshfp" {
  zone = "${gandi_zone.mtb_wtf.id}"
  name = "bsd"
  type = "SSHFP"
  ttl  = "300"

  values = [
    "1 1 c18a005374e423e57d4f3fbc261934860607561a",
    "1 2 1f70f21e53771c5f4f9f8833a2073f8aadee590528603127a5e046fa0a6707a8",
    "2 1 358a186ae26441ad349170ce6847104bc09fbc04",
    "2 2 3fdf175370355a506d68f19100f1c18768e3bb37ce1d94a192ee46d5ba32b65e",
    "3 1 7ad76cbae37445f87e15d0b37da106b6f4c96093",
    "3 2 07a512648d5e2c286846106cd80020b071034d6bf6b39adae3e2bf33deb4fb25",
    "4 1 d2e44ab1655fc2ba070035b0ac5ec514defa06b6",
    "4 2 7ca1e12c57485384f1988c3d33bf4fa64b69168bb4853152ca91f8e28b435539"
  ]
}

resource "gandi_zonerecord" "mn_mtb_wtf_a" {
  zone = "${gandi_zone.mtb_wtf.id}"
  name = "mn"
  type = "A"
  ttl  = "300"

  values = ["159.65.40.205"]
}

resource "gandi_zonerecord" "mn_mtb_wtf_aaaa" {
  zone = "${gandi_zone.mtb_wtf.id}"
  name = "mn"
  type = "AAAA"
  ttl  = "300"

  values = ["2604:a880:800:a1::c15:1001"]
}

resource "gandi_zonerecord" "mn_mtb_wtf_sshfp" {
  zone = "${gandi_zone.mtb_wtf.id}"
  name = "mn"
  type = "SSHFP"
  ttl  = "300"

  values = [
    "1 1 c17f522e22293b8a8a102b15b21cadaadb600154",
    "1 2 91f936452dc90f9c7707f57d8c7e765179b77fe05dd731d74ea18c0df6f026a8",
    "2 1 d0aef90a852b8301f26e4dfa3e176ffe7bcbaecc",
    "2 2 65f575e9522bcc41d8cb3ee99012965cd7a5e9d5345cc2917a97681bd0603f39",
    "3 1 bc83623016af24bf91d4f0e3d11fc2bf86aa47d2",
    "3 2 c9b553b79209351988eba5ef3003c3413175457cdd05ac5c848f83de33041cea",
    "4 1 03c7557b1be1bd0f38918733b00836b9e32eb18c",
    "4 2 5df42328bf5f9dcf4056887508f470dbdf6be156608c37e0c849873fa25f37ab"
  ]
}

resource "gandi_zonerecord" "mtb_wtf_sshfp" {
  zone = "${gandi_zone.mtb_wtf.id}"
  name = "@"
  type = "SSHFP"
  ttl  = "300"

  values = [
    "1 1 32b1cc6c838fbbe1a3bea8f8a3651a850c357315",
    "1 2 9ddadc80ab34f2a3bd011b54dca9a814e2223ace89897ee050e8db158cc550e7",
    "2 1 e1f1c57544edd21619f7a6d55da5483708c056c7",
    "2 2 904a2aa1eb7d5522e3d2c78299e6fd22aad22023e210fc9ddf04eb4ba598c472",
    "3 1 fa153f5faee2465e8177dec4c40e0d203f8c6b45",
    "3 2 b6d994dd3376b6ce7cf72b9d14e61196a19e097ad858fb15cc7516d3d98f1989",
    "4 1 4072c08f9185beaf0c45a51fc21e8eb6b9ca2b15",
    "4 2 f078cd5d5c87b59748729fec00a3653f4639d62df79050bbdafa970bcbcc6b7a"
  ]
}
