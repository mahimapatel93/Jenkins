# Day 1 – CI/CD (Continuous Integration & Continuous Deployment)

## What is CI/CD?

CI/CD is a DevOps methodology that automates the entire software delivery process, including:

- Integrating code changes  
- Running automated tests  
- Performing quality checks  
- Deploying applications  

It helps teams release software quickly, securely, and consistently.

---

## CI – Continuous Integration

### Definition

Continuous Integration is a process where developers regularly upload their code to a common repository, and each update is automatically built and tested.

---

### CI Process Flow

Developer writes code  
⬇️  
Code pushed to GitHub  
⬇️  
Build process starts  
⬇️  
Automated testing runs  
⬇️  
Code quality analysis  

---

### Build Stage

- Converts code into a deployable package  
- Installs required dependencies and libraries  

**The build package contains:**
- Application source code  
- Required dependencies  
- Libraries  
- Executable files  

---

### Testing Stage

- Confirms application works correctly  
- Finds bugs at an early stage  
- Ensures new updates don’t affect existing features  

---

### Code Quality Stage

This stage checks:
- Coding standards  
- Code smells  
- Security issues  

**Common tool:** SonarQube  

---

## CD – Continuous Deployment / Continuous Delivery

### Definition

CD automatically deploys the verified code to servers or environments after the CI process is completed.

---

### CD Process Flow

Output from CI (Artifact)  
⬇️  
Stored in artifact repository  
⬇️  
Application deployment  
⬇️  
Application goes live  

---

### Artifact Storage Tools

- Amazon S3  
- JFrog Artifactory  
- Nexus Repository  

---

## CI/CD Tools

### Popular tools used in industry:

- Jenkins  
- GitHub Actions  
- GitLab CI/CD  
- Azure DevOps  

---

## Jenkins (Important Tool in DevOps)

### What is Jenkins?

Jenkins is an open-source automation server used to manage CI/CD pipelines for building, testing, and deploying applications.

---

### Jenkins Key Details

- **Default Port:** 8080  
- **Default Workspace Location:**  
  `/var/lib/jenkins`

---

### Minimum System Requirements

- RAM: 2 GB  
- CPU: 2 cores minimum  

---

### Important Jenkins Plugins

- **Pipeline Plugin** – Used to define CI/CD workflow  
- **Stage View Plugin** – Displays pipeline stages visually  

---

### Jenkins Pipeline Concept

**CI Pipeline**  
GitHub → Build → Test → Code Quality Check  

**CD Pipeline**  
Artifact → Deployment → Application Live  

---

## Why CI/CD is Important?

- Faster application releases 🚀  
- Early identification of bugs 🐞  
- Automation reduces manual mistakes  
- Increases developer productivity  
- Widely used DevOps best practice  

---

## One-Line Interview Answer

**“CI/CD automates code integration, testing, quality validation, and deployment to deliver applications efficiently and reliably.”**
