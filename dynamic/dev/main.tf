terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket         = "ecs-dfanso"
    key            = "dynamic/dev/terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.credentials_profile

  default_tags {
    tags = merge(
      {
        Project     = var.project_name
        Environment = "dev"
        ManagedBy   = "terraform"
      },
      var.tags
    )
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

# Remote state for persistence layer
data "terraform_remote_state" "persistence" {
  backend = "s3"
  config = {
    bucket = "ecs-dfanso"
    key    = "persistence/terraform.tfstate"
    region = "ap-southeast-1"
  }
}
