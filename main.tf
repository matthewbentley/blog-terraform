resource "aws_route53_zone" "bentley_link" {
    name = "bentley.link"
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

module "staging_bentley_blog" {
    source = "./site_domain"
    name = "staging.bentley.blog"
    aliases = [
        "staging.bentley.blog",
        "www.staging.bentley.blog",
        "staging.bentley.link",
        "www.staging.bentley.link"
    ]
    cert = "${data.aws_acm_certificate.bentley_megacert.arn}"
    log_bucket_id = "${aws_s3_bucket.logs.id}"
    log_bucket_domain_name = "${aws_s3_bucket.logs.bucket_domain_name}"
    
    region = "us-east-1"
}

module "bentley_blog" {
    source = "./site_domain"
    name = "bentley.blog"
    aliases = [
        "bentley.blog",
        "www.bentley.blog",
        "bentley.link",
        "www.bentley.link"
    ]
    cert = "${data.aws_acm_certificate.bentley_megacert.arn}"
    log_bucket_id = "${aws_s3_bucket.logs.id}"
    log_bucket_domain_name = "${aws_s3_bucket.logs.bucket_domain_name}"

    region = "us-east-1"
}
