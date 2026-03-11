# Online Salon Booking System (MERN + DevOps)

An enterprise-grade, full-stack web application designed to streamline salon management while showcasing a modern, automated DevOps lifecycle.

---

## Project Overview
The Online Salon Booking System is a decoupled client-server platform that improves the customer booking experience. Beyond its functional features, this project serves as a demonstration of Infrastructure as Code (IaC), Containerization, and Automated CI/CD Pipelines for scalable cloud deployment.

## Tech Stack

| Layer | Technologies |
| :--- | :--- |
| Frontend | React 18, Redux Toolkit, Axios, CSS/Responsive UI |
| Backend | Node.js, Express.js (REST API) |
| Database | MongoDB (Mongoose ODM) |
| DevOps | Docker, Jenkins, Terraform, AWS (EC2, VPC, Security Groups) |

---

## Key Features

### Customer Portal
* Secure Auth: JWT-based authentication and authorization.
* Real-time Booking: Interactive appointment scheduling and history tracking.
* Profiles: Manage personal data and previous visit records.

### Stylist Management
* Approval Workflow: Formal stylist application and admin approval system.
* Portfolio: Customizable profiles to showcase professional work and skills.
* Schedule Management: Personal dashboard for daily availability.

### Administrative Dashboard
* RBAC: Role-Based Access Control to manage users and stylists.
* Monitoring: Platform-wide data tracking and stylist verification.

---

## DevOps & Cloud Architecture

This project implements a "Shift-Left" approach to deployment using modern automation tools:

* Containerization: Multi-stage Docker builds for optimized, production-ready images.
* Service Orchestration: Docker Compose used for consistent local development.
* CI/CD Pipeline: Jenkins automates the entire build, test, and push lifecycle.
* Infrastructure as Code: Terraform scripts automate the provisioning of AWS EC2 instances and networking.

### Deployment Workflow
1. Code: Developer pushes updates to GitHub.
2. Build: Jenkins triggers an automated build and test process.
3. Ship: Docker images are pushed to a container registry.
4. Provision: Terraform ensures the AWS infrastructure is correctly configured.
5. Deploy: Containers are pulled and deployed to the AWS EC2 server via Elastic IP.

---

## Key Learning Outcomes
* System Design: Implementing robust Role-Based Access Control (RBAC).
* Automation: Designing end-to-end CI/CD pipelines to eliminate manual deployment.
* Cloud Infrastructure: Using Terraform to manage AWS resources as code.
* State Management: Handling complex application logic with Redux Toolkit.

---

## Author
Shimrin
* GitHub: [shimrin23](https://github.com/shimrin23)
* LinkedIn: [shimrin0123](https://www.linkedin.com/in/shimrin0123)
