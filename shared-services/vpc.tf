module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0"

  name = "${var.project_name}-shared-vpc"
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  enable_dns_hostnames   = true
  enable_dns_support     = true

  # VPC Flow Logs
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

  public_subnet_tags = {
    Type = "public"
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    Type = "private"
    "kubernetes.io/role/internal-elb" = 1
  }
}
