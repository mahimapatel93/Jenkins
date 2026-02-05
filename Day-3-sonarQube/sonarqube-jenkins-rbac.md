# SonarQube + Jenkins – Role-Based Access Control (RBAC)

## Overview

This document describes how **SonarQube** was integrated with **Jenkins** and how **Role-Based Access Control (RBAC)** was implemented to restrict developers to specific pipelines only.

---

## Objective

- Integrate SonarQube with Jenkins CI pipelines  
- Restrict developers to view and run **only assigned pipelines**  
- Prevent unauthorized access to other pipelines  

---

## Tools & Technologies

- Jenkins  
- SonarQube  
- Role-based Authorization Strategy (Jenkins Plugin)  

---

## Jenkins Configuration – Step by Step

---

## 1. Plugin Installation

### Jenkins Path
Manage Jenkins → Plugins → Available Plugins


### Required Plugins
- SonarQube Scanner for Jenkins  
- Role-based Authorization Strategy  

### Action
- Search plugin name  
- Click **Install**  
- Restart Jenkins if required  

---

## 2. Enable Role-Based Authorization

### Jenkins Path
Manage Jenkins → Security


### Steps
- Authorization → select **Role-Based Strategy**
- Click **Save**

---

## 3. Create Users

### Jenkins Path
Manage Jenkins → Users → Create User


### Example Users
- dev1  
- dev2  

### Action
- Fill username, password, name, email  
- Click **Create User**

---

## 4. Configure SonarQube in Jenkins

### Jenkins Path
Manage Jenkins → System → SonarQube Servers


### Steps
- Click **Add SonarQube**
- Name: `sonar`
- Server URL: `http://<sonarqube-ip>:9000`
- Authentication Token:
  - Add token using **Credentials**
- Save configuration

---

## 5. Add SonarQube to Jenkins Pipeline

### Jenkinsfile (Example)
```groovy
stage('SonarQube Analysis') {
    steps {
        withSonarQubeEnv('sonar') {
            sh 'mvn sonar:sonar'
        }
    }
}

## 6. Role-Based Access Control (RBAC)

### Jenkins Path
Manage Jenkins → Manage and Assign Roles


---

### 6.1 Global Role Configuration

#### Path
Manage Jenkins → Manage and Assign Roles → Manage Roles


#### Global Role
- **Role Name:** `developer`

#### Permissions
- `Overall → Read`  
  *(Allows dashboard access only)*

---

### 6.2 Item Roles (Pipeline-Level Access)

#### Path
Manage Jenkins → Manage and Assign Roles → Manage Roles → Item Roles


#### Steps
- Create role name (example): `pipeline-dev1`
- Job name pattern:
  - `pipeline-dev1.*`  
  **OR**
  - Exact job name

#### Permissions
- `Job → Read`
- `Job → Build`

#### Repeat for other pipelines
- `pipeline-dev2`
- `pipeline-projectA`

---

### 6.3 Assign Roles to Users

#### Path
Manage Jenkins → Manage and Assign Roles → Assign Roles


#### Role Assignment

| User | Global Role | Item Role |
|-----|------------|-----------|
| dev1 | developer | pipeline-dev1 |
| dev2 | developer | pipeline-dev2 |

✔️ Assign **both Global Role and Item Role**  
✔️ Click **Save**

---

## Result

### Developers can:
- Login to Jenkins  
- View Jenkins dashboard  
- Run only their assigned pipelines  

### Developers cannot:
- See other pipelines  
- Edit job configuration  
- Access admin or system settings  

---

## Key Outcome

✅ SonarQube integrated with Jenkins  
✅ RBAC successfully implemented  
✅ Secure and controlled CI execution  
✅ No unauthorized pipeline access  

---

## Notes

- Global role is **mandatory** for Jenkins UI access  
- Item roles work only **after global permission is assigned**  
- Regex or job name must match **exactly**  
- RBAC prevents accidental or unauthorized builds
