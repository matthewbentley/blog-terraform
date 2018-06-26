resource "aws_route53_zone" "bentley_link" {
  name = "bentley.link"
}

resource "namecheap_ns" "bentley_link" {
  domain  = "bentley.link"
  servers = ["${aws_route53_zone.bentley_link.name_servers}"]
}

module "blog_domain_bentley_link" "bentley_link" {
  source     = "./blog_domain"
  domain     = "bentley.link"
  zone_id    = "${aws_route53_zone.bentley_link.zone_id}"
  cf_zone_id = "${module.bentley_blog.cf_distribution_zone_id}"
  cf_name    = "${module.bentley_blog.cf_distribution_domain_name}"
}

module "blog_domain_staging_bentley_link" "staging_bentley_link" {
  source     = "./blog_domain"
  domain     = "staging.bentley.link"
  zone_id    = "${aws_route53_zone.bentley_link.zone_id}"
  cf_zone_id = "${module.staging_bentley_blog.cf_distribution_zone_id}"
  cf_name    = "${module.staging_bentley_blog.cf_distribution_domain_name}"
}

module "fastmail_domain_bentley_link" "bentley_link" {
  source  = "./fastmail_domain"
  domain  = "bentley.link"
  zone_id = "${aws_route53_zone.bentley_link.zone_id}"
}

resource "aws_route53_zone" "bentley_blog" {
  name = "bentley.blog"
}

resource "namecheap_ns" "bentley_blog" {
  domain  = "bentley.blog"
  servers = ["${aws_route53_zone.bentley_blog.name_servers}"]
}

module "blog_domain_catherine_science" "catherine_science" {
  source     = "./blog_domain"
  domain     = "catherine.science"
  zone_id    = "${aws_route53_zone.catherine_science.zone_id}"
  cf_zone_id = "${module.catherine_science.cf_distribution_zone_id}"
  cf_name    = "${module.catherine_science.cf_distribution_domain_name}"
}

module "blog_domain_bentley_blog" "bentley_blog" {
  source     = "./blog_domain"
  domain     = "bentley.blog"
  zone_id    = "${aws_route53_zone.bentley_blog.zone_id}"
  cf_zone_id = "${module.bentley_blog.cf_distribution_zone_id}"
  cf_name    = "${module.bentley_blog.cf_distribution_domain_name}"
}

module "blog_domain_staging_bentley_blog" "staging_bentley_blog" {
  source     = "./blog_domain"
  domain     = "staging.bentley.blog"
  zone_id    = "${aws_route53_zone.bentley_blog.zone_id}"
  cf_zone_id = "${module.staging_bentley_blog.cf_distribution_zone_id}"
  cf_name    = "${module.staging_bentley_blog.cf_distribution_domain_name}"
}

module "fastmail_domain_bentley_blog" "bentley_blog" {
  source  = "./fastmail_domain"
  domain  = "bentley.blog"
  zone_id = "${aws_route53_zone.bentley_blog.zone_id}"
}

data "aws_acm_certificate" "bentley_megacert" {
  domain = "bentley.link"
}

data "aws_acm_certificate" "catherine_science" {
  domain = "catherine.science"
}

resource "aws_s3_bucket" "logs" {
  bucket_prefix = "logs-"
  region        = "us-east-1"
  acl           = "log-delivery-write"
}

module "catherine_science" {
  source = "./site_domain"
  name   = "catherine.science"

  aliases = [
    "catherine.science",
    "www.catherine.science",
  ]

  cert                   = "${data.aws_acm_certificate.catherine_science.arn}"
  log_bucket_id          = "${aws_s3_bucket.logs.id}"
  log_bucket_domain_name = "${aws_s3_bucket.logs.bucket_domain_name}"

  region = "us-east-1"
}

module "staging_bentley_blog" {
  source = "./site_domain"
  name   = "staging.bentley.blog"

  aliases = [
    "staging.bentley.blog",
    "www.staging.bentley.blog",
    "staging.bentley.link",
    "www.staging.bentley.link",
  ]

  cert                   = "${data.aws_acm_certificate.bentley_megacert.arn}"
  log_bucket_id          = "${aws_s3_bucket.logs.id}"
  log_bucket_domain_name = "${aws_s3_bucket.logs.bucket_domain_name}"

  lambda_functions = [
    {
      event_type = "origin-request"
      lambda_arn = "arn:aws:lambda:us-east-1:822323900684:function:bentley-link-save-comment:14"
    },
    {
      event_type = "viewer-response"
      lambda_arn = "arn:aws:lambda:us-east-1:822323900684:function:add-resp-headers:14"
    },
  ]

  region = "us-east-1"
}

module "bentley_blog" {
  source = "./site_domain"
  name   = "bentley.blog"

  aliases = [
    "bentley.blog",
    "www.bentley.blog",
    "bentley.link",
    "www.bentley.link",
  ]

  cert                   = "${data.aws_acm_certificate.bentley_megacert.arn}"
  log_bucket_id          = "${aws_s3_bucket.logs.id}"
  log_bucket_domain_name = "${aws_s3_bucket.logs.bucket_domain_name}"

  lambda_functions = [
    {
      event_type = "origin-request"
      lambda_arn = "arn:aws:lambda:us-east-1:822323900684:function:bentley-link-save-comment:14"
    },
    {
      event_type = "viewer-response"
      lambda_arn = "arn:aws:lambda:us-east-1:822323900684:function:add-resp-headers:14"
    },
  ]

  region = "us-east-1"
}

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

resource "aws_route53_record" "kbp_mtb_wtf_txt" {
  zone_id = "${aws_route53_zone.mtb_wtf.zone_id}"
  name    = "_keybase_pages.kbp.mtb.wtf"
  type    = "TXT"
  ttl     = "300"

  records = ["kbp=/keybase/private/bentley,kbpbot/my-site"]
}

resource "aws_route53_zone" "catherine_science" {
  name = "catherine.science"
}

resource "namecheap_ns" "catherine_science" {
  domain  = "catherine.science"
  servers = ["${aws_route53_zone.catherine_science.name_servers}"]
}

module "fastmail_domain_catherine_science" "catherine_science" {
  source  = "./fastmail_domain"
  domain  = "catherine.science"
  zone_id = "${aws_route53_zone.catherine_science.zone_id}"
  caa     = ["letsencrypt.org", "amazon.com"]
}
