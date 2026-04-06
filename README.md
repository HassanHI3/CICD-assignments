# 🚀 CI/CD Pipeline with Docker, AWS & Terraform

This project demonstrates building a basic CI pipeline and a simple CD workflow to deploy a containerised Flask application.
---

## 📌 Tasks

### Task 1 – CI
- Triggered on push/PR  
- Installs dependencies  
- Runs unit tests with `pytest`  

### Task 2 – CD
- Builds Docker image  
- Pushes image to Amazon ECR  
- Deploys app to AWS ECS (Fargate)  
- Provisions infrastructure using Terraform  

---

## 🛠️ Tech Stack

- Docker  
- AWS (ECR, ECS Fargate)  
- Terraform  
- GitHub Actions  
- Python (Flask, Pytest)  

---

## ⚙️ Project Structure
- chapter1/
- app.py
- test_app.py
- requirements.txt
- Dockerfile
- main.tf

- .github/workflows/
- ci.yaml
- cd.yaml


---

## 🐳 Run Locally

```bash
docker build -t my-app .
docker run -p 5001:5000 my-app
```
Open: http://localhost:5001

### Deploy with Terraform

```bash
terraform init
terraform plan
terraform apply
```
### Run Tests

```bash
pytest
```
### Key Takeaways
- Built end-to-end CI/CD pipeline
- Deployed containerised app to AWS ECS
- Debugged real-world issues (networking, ECR, container crashes)

### Future Improvements
- Add Load Balancer (ALB)
- Private subnets + NAT
- Auto-scaling
