# DevOps-Terraform
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
1.main.tf
2.variables.tf
3.ecr.tf
4.rds.tf
5.ecs.tf(Simplified)
  Create:

ECS Cluster

Task Definition

ECS Service

Security groups

Load Balancer (ALB)

+ Step 4: Initialize and Apply Terraform
+ Step 5:Create GitHub Actipn workflow
+ Create .github/workflows/deploy.yml in  project
+ Step 6: Add GitHub Secrets
+ Go to GitHub → Repo → Settings → Secrets and add:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

Step 7: Validate Deployment
Visit the Application Load Balancer URL

Confirm Medusa backend is accessible (/store/products)

Use CloudWatch Logs to debug ECS if needed





