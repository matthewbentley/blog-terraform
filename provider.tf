provider "aws" {
  region = "us-east-1"
}

provider "namecheap" {
  use_sandbox = false
}

provider "gandi" {}

terraform {
  backend "s3" {
    bucket = "bentley-remote-state"
    key    = "bentley-link.tfstate"
    region = "us-east-1"
  }
}
