# Session 18: Terraform — Infrastructure as Code (IaC)

Managing cloud infrastructure manually through the AWS Console is slow, error-prone, and impossible to reproduce consistently.

Terraform solves this. It lets you define infrastructure as code and provision it with a single command.

---

## What is Terraform?

Terraform is an open-source Infrastructure as Code (IaC) tool by HashiCorp. You write declarative configuration files (`.tf`), and Terraform creates, updates, and destroys cloud resources to match your desired state.

---

## Topics Covered

| Folder | Topic |
|--------|-------|
| `01-iac-basics/` | What is IaC, benefits of IaC, declarative vs imperative |
| `02-terraform-architecture/` | Terraform architecture, providers, state, plan/apply cycle |
| `03-providers/` | Configuring the AWS provider, required_providers block |
| `04-resources/` | Defining resources, resource blocks, tags |
| `05-variables/` | Input variables, types, defaults, descriptions |
| `06-outputs/` | Output values, displaying resource attributes after apply |
| `07-init-plan-apply/` | terraform init, plan, apply workflow |
| `08-destroy/` | terraform destroy, cleaning up resources |
| `09-state/` | Terraform state, state list, state show |
| `terraform-s3-demo/` | Full S3 bucket deployment: init → plan → apply → verify → destroy |

---

## Core Concepts

**Provider:** A plugin that lets Terraform interact with a cloud platform (AWS, GCP, Azure). You configure it with a region and credentials.

**Resource:** A single piece of infrastructure (an S3 bucket, an EC2 instance, a VPC). Defined using `resource` blocks in `.tf` files.

**State:** Terraform's record of what infrastructure it manages. Stored in `terraform.tfstate`. This is how Terraform knows what exists and what needs to change.

**Plan:** A preview of what Terraform will do before it does it. Shows resources to add, change, or destroy.

---

## Prerequisites

Install Terraform:

```bash
# https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform -version
```

Install AWS CLI:

```bash
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
brew install awscli
aws --version
```

Configure AWS credentials:

```bash
aws configure
# AWS Access Key ID: <your-access-key>
# AWS Secret Access Key: <your-secret-key>
# Default region name: us-east-1
# Default output format: json
```

Verify:

```bash
aws sts get-caller-identity
```

---

## Project Structure — S3 Demo

```text
terraform-s3-demo/
├── terraform.tf       # Terraform version and provider requirements
├── providers.tf       # AWS provider configuration (region)
├── variables.tf       # Input variables (region, bucket name)
├── main.tf            # Resource definition (S3 bucket)
├── outputs.tf         # Output values (bucket name, ARN, region)
└── .gitignore         # Ignore .terraform/, state files
```

---

## Key Commands

```bash
# Initialize Terraform (download providers)
terraform init

# Format configuration files
terraform fmt

# Validate configuration syntax
terraform validate

# Preview what will be created/changed/destroyed
terraform plan

# Apply the configuration (create resources)
terraform apply

# List resources in state
terraform state list

# Show details of a specific resource
terraform state show aws_s3_bucket.devops553

# Display output values
terraform output

# Preview what will be destroyed
terraform plan -destroy

# Destroy all managed resources
terraform destroy
```

---

## Terraform Lifecycle

```text
  Write .tf files
        │
        ▼
  terraform init        ← Download provider plugins
        │
        ▼
  terraform validate    ← Check syntax and configuration
        │
        ▼
  terraform plan        ← Preview changes (+ create, ~ update, - destroy)
        │
        ▼
  terraform apply       ← Execute changes on AWS
        │
        ▼
  terraform state       ← Track what was created
        │
        ▼
  terraform destroy     ← Clean up resources
```

---

## Assignment: Deploy an S3 Bucket with Terraform

### Step 1 — Initialize Terraform

Run `terraform init` to download the AWS provider plugin. Then run `terraform validate` to confirm the configuration is valid.

After that, run `terraform plan` to preview the S3 bucket that will be created.

![Step 1 — terraform init, validate, and plan](images/Screenshot%202026-10-07%20at%2015.49.15.png)

**What happened:**
- `terraform init` downloaded the `hashicorp/aws` provider (v6.66.0)
- `terraform validate` confirmed the configuration is valid
- `terraform plan` showed **1 resource to add** — an S3 bucket named `yatri1107` in `us-east-1` with tags for Environment, ManagedBy, Name, and Project

---

### Step 2 — Apply the Configuration

Run `terraform apply` to create the S3 bucket on AWS. Terraform shows the execution plan again and asks for confirmation.

![Step 2 — terraform apply execution plan](images/Screenshot%202026-10-07%20at%2015.49.23.png)

**What happened:**
- Terraform displayed the same plan: 1 S3 bucket to create
- It prompted `Do you want to perform these actions?`
- After entering `yes`, Terraform proceeded to create the bucket

---

### Step 3 — Verify the Deployment

After the apply completes, verify the bucket was created using Terraform state, outputs, and the AWS CLI.

![Step 3 — apply complete, state list, output, and aws s3 ls](images/Screenshot%202026-10-07%20at%2015.49.27.png)

**What happened:**
- `Apply complete! Resources: 1 added, 0 changed, 0 destroyed.`
- `terraform state list` → `aws_s3_bucket.devops553`
- `terraform output` showed:
  - `bucket_arn = "arn:aws:s3:::yatri1107"`
  - `bucket_name = "yatri1107"`
  - `bucket_region = "us-east-1"`
- `aws s3 ls` confirmed the bucket exists: `2026-10-07 15:47:43 yatri1107`

---

## Configuration Files

### terraform.tf

```hcl
terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
```

### providers.tf

```hcl
provider "aws" { region = var.aws_region }
```

### variables.tf

```hcl
variable "aws_region" {
  type        = string
  description = "AWS region where the S3 bucket will be created."
  default     = "us-east-1"
}
variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket."
  default     = "yatri1107"
}
```

### main.tf

```hcl
resource "aws_s3_bucket" "devops553" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = {
    Name        = var.bucket_name
    Environment = "dev"
    ManagedBy   = "Terraform"
    Project     = "Session18"
  }
}
```

### outputs.tf

```hcl
output "bucket_name" {
  type        = string
  description = "Name of the S3 bucket."
  value       = aws_s3_bucket.devops553.bucket
}
output "bucket_arn" {
  type        = string
  description = "ARN of the S3 bucket."
  value       = aws_s3_bucket.devops553.arn
}
output "bucket_region" {
  type        = string
  description = "AWS region of the S3 bucket."
  value       = aws_s3_bucket.devops553.region
}
```

---

## Interview Preparation

**Beginner:**

Q: What is Terraform?
A: Terraform is an open-source IaC tool by HashiCorp. You write `.tf` files describing your desired infrastructure, and Terraform creates, updates, or destroys cloud resources to match that state.

Q: What is the difference between `terraform plan` and `terraform apply`?
A: `plan` is a dry run — it shows what will happen without making changes. `apply` executes the plan and actually creates/modifies/destroys resources.

**Intermediate:**

Q: What is Terraform state and why is it important?
A: State (`terraform.tfstate`) is Terraform's record of what it manages. It maps your `.tf` configuration to real cloud resources. Without state, Terraform would not know what already exists and would try to recreate everything.

Q: What does `force_destroy = true` do on an S3 bucket?
A: It allows `terraform destroy` to delete the bucket even if it contains objects. Without it, Terraform would fail to destroy a non-empty bucket.

**Scenario-Based:**

Q: You run `terraform apply` and get an AccessDenied error. What do you check?
A: Check that the IAM user has the required permissions (e.g., `s3:CreateBucket`). Also check if the account is part of an AWS Organization with a Service Control Policy (SCP) that explicitly denies the action — SCPs override IAM policies.

---

## Reference

* **Terraform Documentation:** https://developer.hashicorp.com/terraform/docs
* **Terraform AWS Provider:** https://registry.terraform.io/providers/hashicorp/aws/latest/docs
* **Terraform Get Started — AWS:** https://developer.hashicorp.com/terraform/tutorials/aws-get-started
* **AWS CLI Installation:** https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
