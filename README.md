# Medusa with terraform using GitHub Action
Deploy the Medusa.js backend on AWS ECS Fargate using Terraform
+ Automate Continuous Deployment (CD)
+  Step 1: Understand the Stack
+   An open-source, headless commerce backend
+   Built with Node.js
+   Uses PostgreSQL, Redis (for caching), and file storage (S3)
+ Step 2:  Create a Dockerfile
+ In the Medusa root folder (medusa-server/), create
+ Step 3: Create Terraform Files
+ Create a folder terraform/ and inside it
+ 1.main.tf
    provider "aws" {
    region = "us-east-1"
  }

+ 2.variables.tf
  variable "db_password" {}

+ 3.ecr.tf
  resource "aws_ecr_repository" "medusa" {
  name = "medusa-backend"
}

+ 4.rds.tf
  resource "aws_db_instance" "medusa_db" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "13"
  instance_class       = "db.t3.micro"
  name                 = "medusadb"
  username             = "admin"
  password             = var.db_password
  skip_final_snapshot  = true
}

+ 5.ecs.tf(Simplified)
  Create:

ECS Cluster

Task Definition

ECS Service

Security groups

Load Balancer (ALB)

+ Step 4: Initialize and Apply Terraform
  cd terraform/
terraform init
terraform plan
terraform apply

+ Step 5:Create GitHub Actipn workflow
+ Create .github/workflows/deploy.yml in  project
  name: Deploy Medusa to ECS

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2

    - name: Set up Docker
      uses: docker/setup-buildx-action@v1

    - name: Configure AWS credentials
      uses: aws-actions/configure-aws-credentials@v2
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-region: us-east-1

    - name: Log in to Amazon ECR
      run: |
        aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-east-1.amazonaws.com

    - name: Build and push Docker image
      run: |
        docker build -t medusa-backend .
        docker tag medusa-backend:latest <account-id>.dkr.ecr.us-east-1.amazonaws.com/medusa-backend:latest
        docker push <account-id>.dkr.ecr.us-east-1.amazonaws.com/medusa-backend:latest

    - name: Terraform Deploy
      run: |
        cd terraform
        terraform init
        terraform apply -auto-approve

+ Step 6: Add GitHub Secrets
+ Go to GitHub → Repo → Settings → Secrets and add:
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
+ Step 7: Validate Deployment
+ Visit the Application Load Balancer URL
+ Confirm Medusa backend is accessible (/store/products)
+ Use CloudWatch Logs to debug ECS if needed





