<p align="center">
  <a href="https://www.medusajs.com">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://user-images.githubusercontent.com/59018053/229103275-b5e482bb-4601-46e6-8142-244f531cebdb.svg">
    <source media="(prefers-color-scheme: light)" srcset="https://user-images.githubusercontent.com/59018053/229103726-e5b529a3-9b3f-4970-8a1f-c6af37f087bf.svg">
    <img alt="Medusa logo" src="https://user-images.githubusercontent.com/59018053/229103726-e5b529a3-9b3f-4970-8a1f-c6af37f087bf.svg">
    </picture>
  </a>
</p>
<h1 align="center">
  Medusa
</h1>

# Medusa Backend Deployment on AWS ECS with Terraform & GitHub Actions

This project demonstrates how to deploy the **Medusa.js backend** to **AWS ECS (Fargate)** using **Terraform** for infrastructure provisioning and **GitHub Actions** for CI/CD automation. It follows DevOps best practices for scalability, security, and automation.

---

## Live Infrastructure Overview

- **Containerized Backend**: Medusa.js in optimized multi-stage Docker image (size reduced from **1.06 GB → 154 MB**)
- **CI/CD Pipeline**: Automated with GitHub Actions (build, push, deploy)
- **AWS Resources**: ECS (Fargate), ALB, RDS (PostgreSQL), VPC, IAM, CloudWatch
- **IaC**: Entire infrastructure provisioned with modular Terraform code

---

## Tools & Technologies

- **Cloud**: AWS (ECS Fargate, ALB, RDS PostgreSQL, CloudWatch, IAM, VPC)
- **CI/CD**: GitHub Actions
- **IaC**: Terraform
- **Containers**: Docker (multi-stage builds)
- **Monitoring**: AWS CloudWatch
- **Security**: IAM roles, security groups, environment variables

---

## Deployment Process

1. **Write Terraform configurations** for:
   - VPC, Subnets, ALB
   - ECS Cluster, Fargate Services
   - RDS PostgreSQL
   - IAM, Security Groups

2. **Build & Push Docker Image**
   - Multi-stage Dockerfile to reduce image size
   - Pushed to Docker Hub on every GitHub push

3. **CI/CD with GitHub Actions**
   - On push → build & push Docker image
   - Update ECS service to pull the latest image

4. **Access the Medusa backend** via the ALB's public DNS

---

## Challenges Faced

- **Admin panel error**  
  `Could not find index.html in the admin build directory`  
  → Fixed by running `medusa build` before starting the server

- **Database not migrating**  
  → Resolved by modifying **RDS parameter group** to support necessary extensions/configs

- **Heavy Docker image**  
  → Solved using **multi-stage Docker build**, reduced size from **1.06 GB to 154 MB**

---

## Outcomes

- Complete infrastructure and deployment automated end-to-end
- Lightweight container images for faster ECS deployment
- Error handling and environment-specific fixes applied
- Real-world production-style DevOps implementation

---

## 📚 Project Document

- [📄 View Document](https://github.com/RameshXT/medusa-backend-deploy/raw/master/docs/Medusa%20Backend%20%20Deployment.pptx)  
- <a href="https://github.com/RameshXT/medusa-backend-deploy/raw/master/docs/Medusa%20Backend%20%20Deployment.pptx" download>⬇️ Download Document</a>

---

## 📫 Contact

**Ramesh Kanna**  
rameshkanna841@gmail.com • [LinkedIn](https://www.linkedin.com/in/ramesh-kanna-g-325042285/) • [Portfolio](https://rameshxt.pages.dev)
