variable "project_name" {
  description = "Project name to be used as a prefix for all resources"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., dev, prod)"
  type        = string
}

variable "service_name" {
  description = "Name of the service"
  type        = string
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
}

variable "domain_name" {
  description = "Domain name for the service"
  type        = string
}

variable "container_image" {
  description = "Docker image to run in the ECS cluster"
  type        = string
}

variable "container_cpu" {
  description = "CPU units for the container (1 vCPU = 1024)"
  type        = number
}

variable "container_memory" {
  description = "Memory for the container (in MiB)"
  type        = number
}

variable "container_environment" {
  description = "Environment variables for the container"
  type        = map(string)
  default     = {}
}

variable "container_secrets" {
  description = "Secrets for the container from AWS Secrets Manager"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "alb_arn" {
  description = "ARN of the Application Load Balancer"
  type        = string
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate"
  type        = string
}

variable "alb_security_group_id" {
  description = "ID of the ALB security group"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}

variable "desired_count" {
  description = "Desired number of tasks"
  type        = number
  default     = 1
}

variable "min_capacity" {
  description = "Minimum number of tasks"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of tasks"
  type        = number
  default     = 3
}

variable "health_check_path" {
  description = "Path for health check"
  type        = string
  default     = "/health"
}

variable "health_check_timeout" {
  description = "Timeout for health check"
  type        = number
  default     = 5
}

variable "health_check_interval" {
  description = "Interval between health checks"
  type        = number
  default     = 30
}

variable "cloudflare_account_id" {
  description = "Cloudflare account ID"
  type        = string
}
