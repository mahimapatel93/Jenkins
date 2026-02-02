# Jenkins Master–Slave (Controller–Agent, SSH method) Setup Documentation

## Overview
This document explains the Jenkins Master–Slave (Controller–Agent) architecture implemented on AWS EC2 instances, including execution of pipelines on private servers using **Controller-Agent and SSH methods via a Load Balancer**.

This setup improves scalability, security, and performance by distributing workloads across multiple agent nodes.

---

## Jenkins Architecture

### High-Level Flow
## Jenkins Master–Slave Architecture with Load Balancer

```text
                +-----------------------------+
                |        Jenkins Master       |
                |            (EC2)            |
                |      SSH Private Key        |
                +--------------+--------------+
                               |
                      Application Load Balancer
                               |
                 Controller-Agent / SSH
                               |
    -----------------------------------------------------------
    |                         |                             |
+---------------+        +---------------+             +---------------+
|   Slave-1     |        |   Slave-2     |             |   Slave-3     |
| (Agent Mode)  |        |  (SSH Agent)  |             |  (SSH Agent)  |
|     EC2       |        |     EC2       |             |     EC2       |
|  Public Key   |        |  Public Key   |             |  Public Key   |
+-------+-------+        +-------+-------+             +-------+-------+
        |                        |                             |
     Docker               App Deployment                   Terraform




---

## Key Concepts

- Jenkins is installed **only on the Master**
- Slaves (Agents) execute jobs assigned by the Master
- Communication between Master and Agents happens via **SSH**
- Pipelines are routed to agents using **labels**
- Supports execution on **private servers via Load Balancer**

---

## EC2 Instances Created

1. Jenkins Master (EC2)
2. Slave-1 (Controller-Agent)
3. Slave-2 (SSH Agent)
4. Optional additional slaves for scaling

---

## Jenkins Master Setup

- Installed:
  - Java
  - Jenkins
  - Git
  - Terraform
- Jenkins unlocked using:


  ```
         
    ## Private Jenkins Master Setup

     - Jenkins Master deployed in private subnet
     - Load Balancer created and attached
     - Target Group configured
     - Allowed traffic:
     - Port: `8080`
     - Protocol: `HTTP`

           http://<load-balancer-dns>:8080
  ```

- Recommended plugins installed
- Master used only for orchestration

---

## Agent Node Configuration

### Slave-1 (Controller-Agent Method)

- Node Name: `slave-1`
- Type: Permanent Agent
- Executors: `1`
- Remote Root Directory: `/home/ec2-user`
- Label: `dev`
- Launch Method: Launch agent by connecting it to the controller
- Free Disk Space Threshold: `200 MB`


**Notes**
- Java and Git installed on agent
- Node verified online before execution

---
### Slave-2 (SSH Agent Method)

- Node Name: `slave-2`
- Type: Permanent Agent
- Executors: `1`
- Remote Root Directory: `/home/ec2-user`
- Label: `test`
- Launch Method: Launch agents via SSH


#### SSH Configuration
- Host: `<private-ec2-ip>`
- Credentials:
  - Username: `ec2-user`
  - Authentication: SSH private key (.pem)
- Host Key Verification Strategy:
  ```
    Non-verifying Verification Strategy
  ```

---


## Pipeline Execution Using Labels

```groovy
pipeline {
    agent { label 'dev' }   // or 'test'
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'git@github.com:username/repo.git'
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}
```

    - Pipeline runs only on matching label
    - If no agent matches, job remains pending

---


---
 
    ## Benefits

    - Secure execution on private servers
    - Scalable architecture
    - Efficient resource utilization
    - Supports Docker, Terraform, and application deployments
    - Label-based job control

---

    ## Resume / LinkedIn Line

     **Executed Jenkins pipelines on private servers using Controller–Agent and SSH methods via Master connected through Load Balancer.**

---

    ## Interview Summary

    Jenkins Master manages scheduling and orchestration, while SSH-connected agents execute pipelines securely on private EC2 servers using label-based routing.
