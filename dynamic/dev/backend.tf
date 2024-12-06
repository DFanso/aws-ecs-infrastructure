locals {
  environment = local.environment
  service_name = "backend"
  container_port = 3000
  domain = "api-dev.${var.domain_name}"
}

module "backend_service" {
  source = "../modules/ecs-service"

  # Service Configuration
  project_name    = var.project_name
  environment     = local.environment
  service_name    = local.service_name
  container_port  = local.container_port
  domain_name     = local.domain

  # Container Configuration
  container_image = "${data.terraform_remote_state.persistence.outputs.ecr_repository_urls["${var.project_name}-${local.service_name}"]}:${var.image_tag}"
  container_cpu    = 256
  container_memory = 512
  container_environment = {
    NODE_ENV = local.environment
  }
  container_secrets = {}

  # Network Configuration
  vpc_id             = data.terraform_remote_state.persistence.outputs.vpc_id
  private_subnet_ids = data.terraform_remote_state.persistence.outputs.private_subnets
  alb_arn           = data.terraform_remote_state.persistence.outputs.alb_arn
  certificate_arn    = data.terraform_remote_state.persistence.outputs.certificate_arn
  
  # Security Groups
  alb_security_group_id = data.terraform_remote_state.persistence.outputs.alb_security_group_id
  
  # IAM Roles
  execution_role_arn = data.terraform_remote_state.persistence.outputs.ecs_task_execution_role_arn
  task_role_arn      = data.terraform_remote_state.persistence.outputs.ecs_task_role_arn

  # Cloudflare Configuration
  cloudflare_account_id = var.cloudflare_account_id

  # Autoscaling Configuration (dev environment)
  desired_count = 1
  min_capacity  = 1
  max_capacity  = 2
  
  # Health Check
  health_check_path = "/health"
  health_check_timeout = 5
  health_check_interval = 30
}
