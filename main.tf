terraform {
  required_version = ">= 1.5.0" # Replace with your current version

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket = "sctp-ce12-tfstate-bucket"  # Change this
    key    = "kuankm/terraform.tfstate2" # Change this
    region = "ap-southeast-1"
  }
}
resource "aws_s3_bucket" "s3_tf" {
  # checkov:skip=CKV_AWS_62: Event bridge notification is not required
  # checkov:skip=CKV_AWS_6: Public access block is handled by account-level settings
  # checkov:skip=CKV_AWS_61: Lifecycle configuration not needed for state files
  # checkov:skip=CKV_AWS_144: Cross-region replication not required
  # checkov:skip=CKV_AWS_21: Logging is not required for this bucket
  # checkov:skip=CKV_AWS_145: Encryption is handled by default S3 encryption
  # checkov:skip=CKV_AWS_18: Access logging not required

  bucket_prefix = "kuankm-tfstate-"
  force_destroy = true
}


