# Jenkins SCM Method Setup Guide

## Overview
The SCM (Source Code Management) option in Jenkins allows your pipeline scripts to be retrieved directly from a Git repository.  
This removes the need to manually type the pipeline script in Jenkins UI.

---

## Configuration Screenshot


*Screenshot shows configuring "Pipeline script from SCM" with Script Path: `Day-2/Jenkinsfile`.*

---

## Step-by-Step Setup

### Step 1: Create or Edit a Pipeline Job
1. Open **Jenkins Dashboard**.  
2. Click **"New Item"** or choose an existing pipeline job.  
3. Provide a name, e.g., **"Terraform-Pipeline"**.  
4. Select **"Pipeline"** as the job type.  
5. Click **OK** to proceed.  

---

### Step 2: Define Pipeline from SCM
1. Scroll to the **Pipeline** section.  
2. Under **Definition**, select **"Pipeline script from SCM"**.  
   - This ensures Jenkins fetches the Jenkinsfile directly from your Git repository.  
   - ✅ Matches the screenshot above.

---

### Step 3: Select SCM System
1. In the **SCM** dropdown, choose **Git**.  
   - This tells Jenkins you are using Git for source control.  
   - ✅ Shown in the screenshot.

---

### Step 4: Set Up Git Repository

#### Repository URL
- Enter the Git repository link:  
  - HTTPS example: `https://github.com/mahimapatel93/Jenkins.git`  
  - SSH example: `git@github.com:username/repository.git`  
  - ✅ Field visible in the screenshot.  

#### Credentials (if required)
- Select credentials if the repository is private.  
- For public repositories, choose **"- none -"**.  
- To add credentials:  
  1. Click the dropdown arrow next to **Credentials**.  
  2. Click **Add → Jenkins**.  
  3. Choose credential type (Username/password, SSH key, etc.).  
  4. Fill in details and click **Add**.  

---

### Step 5: Configure Branch
- **Branch Specifier (leave blank for any):**  
  - Example: `*/main` for the main branch  
  - Other options:  
    - `*/develop` for develop branch  
    - `*/feature/*` for all feature branches  
    - Blank for any branch  
  - ✅ Screenshot shows `*/main`.

---

### Step 6: Specify Script Path
- **Script Path:** Enter the path to your Jenkinsfile relative to the repo root.  
  - Example: `Day-2/Jenkinsfile` ✅  
- This Jenkinsfile typically includes:  
  - Choice parameter for Terraform actions (apply/destroy)  
  - Terraform init, plan, and apply/destroy stages  
  - Works with Terraform files under `Day-1`  

---

### Step 7: Save Configuration
1. Click **Save** to finish.  
   - Or click **Apply** to save without leaving the page.  
2. Jenkins will verify the setup.  
   - ✅ Both buttons shown in the screenshot.

---

## Example Configuration Summary
- **Pipeline Definition:** Pipeline script from SCM  
- **SCM:** Git  
- **Repository URL:** `https://github.com/mahimapatel93/Jenkins.git`  
- **Branch:** `*/main`  
- **Script Path:** `Day-2/Jenkinsfile`  
