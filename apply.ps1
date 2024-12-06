Write-Host "Applying persistence layer..." -ForegroundColor Green
Set-Location -Path "persistence"
terraform init
terraform apply -auto-approve

Write-Host "`nApplying dev environment..." -ForegroundColor Green
Set-Location -Path "..\dynamic\dev"
terraform init
terraform apply
