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

resource "aws_s3_bucket" "logs" {
  bucket_prefix = "logs-"
  region        = "us-east-1"
  acl           = "log-delivery-write"
}

resource "aws_s3_bucket" "remote-state" {
  bucket = "bentley-remote-state"
  region = "us-east-1"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${aws_s3_bucket.logs.id}"
    target_prefix = "tf_log/"
  }
}

data "aws_acm_certificate" "catherine_science" {
  domain = "catherine.science"
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

resource "aws_route53_zone" "pgp_lol" {
  name = "pgp.lol"
}

resource "namecheap_ns" "pgp_lol" {
  domain  = "pgp.lol"
  servers = ["${aws_route53_zone.pgp_lol.name_servers}"]
}

module "fastmail_domain_pgp_lol" "pgp_lol" {
  source  = "./fastmail_domain"
  domain  = "pgp.lol"
  zone_id = "${aws_route53_zone.pgp_lol.zone_id}"
  caa     = ["letsencrypt.org", "amazon.com"]
}

module "blog_domain_pgp_lol" "pgp_lol" {
  source     = "./blog_domain"
  domain     = "pgp.lol"
  zone_id    = "${aws_route53_zone.pgp_lol.zone_id}"
  cf_zone_id = "${module.pgp_lol.cf_distribution_zone_id}"
  cf_name    = "${module.pgp_lol.cf_distribution_domain_name}"
}

data "aws_acm_certificate" "pgp_lol" {
  domain = "pgp.lol"
}

module "pgp_lol" {
  source = "./site_domain"
  name   = "pgp.lol"

  aliases = [
    "pgp.lol",
    "www.pgp.lol",
    "wtf.pgp.lol",
  ]

  cert                   = "${data.aws_acm_certificate.pgp_lol.arn}"
  log_bucket_id          = "${aws_s3_bucket.logs.id}"
  log_bucket_domain_name = "${aws_s3_bucket.logs.bucket_domain_name}"

  region = "us-east-1"
}

resource "aws_route53_record" "ns1-pgp-lol" {
  zone_id = "${aws_route53_zone.pgp_lol.zone_id}"
  name    = "ns1.pgp.lol"
  type    = "A"
  ttl     = "300"

  records = ["104.248.4.245"]
}
