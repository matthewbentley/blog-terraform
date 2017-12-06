variable "name" {}

variable "aliases" {
    type = "list"
}

variable "log_bucket_id" {}

variable "log_bucket_domain_name" {}

variable "cert" {}

variable "region" {}

resource "aws_s3_bucket" "site" {
    bucket = "${var.name}"
    region = "${var.region}"

    versioning {
        enabled = true
    }

    logging {
        target_bucket = "${var.log_bucket_id}"
        target_prefix = "${var.name}/s3-logs/"
    }

    website {
        index_document = "index.html"
        error_document = "error.html"
    }

    policy = <<POLICY
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetBucketObjects",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::${var.name}/*",
                "arn:aws:s3:::${var.name}"
            ]
        }
    ]
}
POLICY
}

resource "aws_cloudfront_distribution" "site" {
    origin {
        domain_name = "${aws_s3_bucket.site.website_endpoint}"
        origin_id   = "s3-site"

        custom_origin_config {
            http_port              = "80"
            https_port             = "443"
            origin_protocol_policy = "http-only"
            origin_ssl_protocols   = ["TLSv1.2"]
        }
    }

    enabled             = true
    is_ipv6_enabled     = true
    default_root_object = "index.html"

    logging_config {
        include_cookies = true
        bucket          = "${var.log_bucket_domain_name}"
        prefix          = "${var.name}/cf-web/"
    }

    aliases = "${var.aliases}"

    default_cache_behavior {
        allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "s3-site"
        compress         = true

        forwarded_values {
            query_string = false

            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy = "redirect-to-https"
        min_ttl                = 0
        default_ttl            = 300
        max_ttl                = 1500

        lambda_function_association {
            event_type = "origin-request"
            lambda_arn = "arn:aws:lambda:us-east-1:822323900684:function:bentley-link-save-comment:14"
        }
        lambda_function_association {
            event_type = "viewer-response"
            lambda_arn = "arn:aws:lambda:us-east-1:822323900684:function:add-resp-headers:9"
        }
    }

    price_class = "PriceClass_All"

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    viewer_certificate {
        acm_certificate_arn = "${var.cert}"
        ssl_support_method  = "sni-only"
    }
}

output "cf_distribution_zone_id" {
    value = "${aws_cloudfront_distribution.site.hosted_zone_id}"
}

output "cf_distribution_domain_name" {
    value = "${aws_cloudfront_distribution.site.domain_name}"
}
