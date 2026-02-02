# Jenkins Master-Slave Setup Documentation

## Overview

This document describes the Jenkins Master-Slave setup implemented for private servers, using both Controller-Agent and SSH methods via a Load Balancer.

## Architecture

```
            +------------------+
            |   Jenkins Master  |
            |   (Master Server) |
            +---------+--------+
                      |
          Load Balancer / SSH Connection
                      |
    --------------------------------------
    |                |                    |
+---------+      +---------+          +---------+
| Slave-1 |      | Slave-2 |          | Slave-3 |
|(Agent)  |      | (SSH)   |          | (SSH)   |
+---------+      +---------+          +---------+
      |                |                    |
   Docker          App Deployment       Terraform
```

## Steps Performed

### 1. Master Server Setup

* Deployed Jenkins Master server.
* Connected Master to private servers through a Load Balancer since private servers are not publicly accessible.
* Unlocked Jenkins and installed recommended plugins.

### 2. Agent Node Configuration

* Created Agent nodes for Controller-Agent method.
* Configured SSH access for private server execution.
* Registered nodes with Master for pipeline execution.
* Set remote root directory, labels, and number of executors.

### 3. Pipeline Execution Methods

* **Controller-Agent**: Master assigns pipeline jobs to Agent nodes.
* **SSH**: Master executes pipelines directly on private servers using SSH.

### 4. Pipeline Example

```groovy
pipeline {
    agent { label 'dev' }  ## test
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

### 5. Benefits

* Secure execution on private servers via Load Balancer.
* Flexible pipeline execution using Controller-Agent and SSH.
* Scalable architecture by adding more Agent nodes.
* Label-based job assignment ensures pipelines run only on intended nodes.

### 6. Resume/LinkedIn Caption

**"Executed Jenkins pipelines on private servers using Controller-Agent and SSH methods via Master connected through Load Balancer."**
