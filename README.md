# AWS ECS Infrastructure

This repository contains Terraform configurations for deploying a scalable AWS ECS (Elastic Container Service) infrastructure. The infrastructure is divided into two main components: persistence (shared resources) and dynamic (environment-specific resources).

## Project Structure

```
.
├── persistence/           # Shared infrastructure resources
│   ├── alb.tf            # Application Load Balancer configuration
│   ├── certificate.tf    # SSL/TLS certificate management
│   ├── ecr.tf           # Elastic Container Registry setup
│   ├── iam.tf           # IAM roles and policies
│   ├── vpc.tf           # VPC and networking configuration
│   └── security_groups.tf # Security group definitions
│
└── dynamic/             # Environment-specific configurations
    ├── modules/         # Reusable Terraform modules
    │   └── ecs-service/ # ECS service module
    └── dev/            # Development environment
        ├── backend.tf   # Backend service configuration
        └── main.tf      # Main Terraform configuration
```

## Infrastructure Components

### Persistence Layer
- **VPC**: Multi-AZ setup with public and private subnets
- **Application Load Balancer**: HTTPS-enabled with TLS 1.3
- **ECR Repositories**: Automated image scanning and lifecycle policies
- **SSL Certificates**: Managed through AWS Certificate Manager
- **Security Groups**: Controlled network access
- **IAM Roles**: Service-specific permissions

### Dynamic Layer (Development Environment)
- **Backend Service**:
  - Container Port: 3000
  - Resource Allocation: 256 CPU units, 512MB memory
  - Auto-scaling enabled
  - Environment-specific domain configuration
  - Integration with shared ALB and VPC

## Prerequisites
- Terraform >= 1.0.0
- AWS CLI configured
- Access to AWS S3 bucket: `ecs-dfanso` for state management

## Deployment Instructions

### 1. Deploy Persistence Layer
```bash
cd persistence
cp terraform.tfvars.example terraform.tfvars
# Update terraform.tfvars with your values
terraform init
terraform apply
```

### 2. Deploy Development Environment
```bash
cd dynamic/dev
cp terraform.tfvars.example terraform.tfvars
# Update terraform.tfvars with your values
terraform init
terraform apply
```

## State Management
- Persistence state: `s3://ecs-dfanso/persistence/terraform.tfstate`
- Dev environment state: `s3://ecs-dfanso/dynamic/dev/terraform.tfstate`

## Security Features
- HTTPS-only communication
- Private subnets for container workloads
- Automated container image scanning
- VPC Flow Logs enabled
- TLS 1.3 with modern cipher suites

## Monitoring
- Container insights enabled
- CloudWatch logging
- Auto-scaling based on resource metrics

## Required Variables
Check `terraform.tfvars.example` in each directory for required variables:
- AWS region and profile
- Project name
- VPC CIDR ranges
- Domain configurations
- Container settings

## Notes
- All infrastructure is managed through Terraform
- State files are encrypted in S3
- Development environment uses shared infrastructure from persistence layer
