variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "project_name" {
  description = "Project name to be used as a prefix for all resources"
  type        = string
}

variable "credentials_profile" {
  description = "AWS credentials profile"
  type        = string
}

variable "domain_name" {
  description = "Base domain name for the application"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "Cloudflare account ID"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag to deploy"
  type        = string
}

variable "tags" {
  description = "Additional tags for resources"
  type        = map(string)
  default     = {}
}
