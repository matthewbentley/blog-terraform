provider "aws" {
  region = "us-east-1"
}

provider "namecheap" {
  use_sandbox = false
}

provider "gandi" {}
