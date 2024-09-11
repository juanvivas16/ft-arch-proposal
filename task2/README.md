# Task 2: Automated Infrastructure with Terraform

This repository contains all the Terraform modules and configurations required to deploy a highly available and cost-effective infrastructure on AWS. The infrastructure includes a VPC, subnets, EC2 instances, an ALB, an RDS database, security groups, and an S3 bucket.

## Table of Contents
- [Task 2: Automated Infrastructure with Terraform](#task-2-automated-infrastructure-with-terraform)
  - [Table of Contents](#table-of-contents)
  - [Modules Overview](#modules-overview)
    - [1. PC Networking Module](#1-pc-networking-module)
    - [2. EC2 Auto Scaling Group (ASG) Module](#2-ec2-auto-scaling-group-asg-module)
    - [3. Application Load Balancer (ALB) Module](#3-application-load-balancer-alb-module)
    - [4. RDS Module](#4-rds-module)
    - [5. S3 Bucket Module](#5-s3-bucket-module)
    - [6. IAM Roles and Policies Module](#6-iam-roles-and-policies-module)
    - [7. Security Groups Module](#7-security-groups-module)
  - [Environment Setup](#environment-setup)
    - [1. Prerequisites](#1-prerequisites)
    - [2. Permissions for the Terraform User](#2-permissions-for-the-terraform-user)
      - [IAM Policy for Terraform User](#iam-policy-for-terraform-user)
    - [3. Environment Vars](#3-environment-vars)
      - [Example `.env` File:](#example-env-file)
        - [Explanation of the Variables:](#explanation-of-the-variables)
  - [How to Deploy, Update, and Destroy the Infrastructure](#how-to-deploy-update-and-destroy-the-infrastructure)
    - [1. Deploy the Infrastructure](#1-deploy-the-infrastructure)
      - [a. Setting Environment](#a-setting-environment)
      - [b. Initialize Terraform](#b-initialize-terraform)
      - [c. Validate the Terraform Plan](#c-validate-the-terraform-plan)
      - [d. Apply the Terraform Plan](#d-apply-the-terraform-plan)
    - [2. Update the Infrastructure](#2-update-the-infrastructure)
      - [a. Make the Necessary Changes](#a-make-the-necessary-changes)
      - [b. Apply the Changes](#b-apply-the-changes)
    - [3. Destroy the Infrastructure](#3-destroy-the-infrastructure)
      - [a. Run the Destroy Command](#a-run-the-destroy-command)
    - [4. Create Another Environment (e.g., `prod`)](#4-create-another-environment-eg-prod)
      - [a. Duplicate the `stg` Folder](#a-duplicate-the-stg-folder)
      - [b. Update Variables for the New Environment](#b-update-variables-for-the-new-environment)
      - [c. Update Enviroment Variables for the New Environment](#c-update-enviroment-variables-for-the-new-environment)
      - [d. Deploy the New Environment](#d-deploy-the-new-environment)
  - [Testing Plan for Infrastructure Setup](#testing-plan-for-infrastructure-setup)
    - [1. Ensuring EC2 Instances Can Serve Web Traffic and Scale Correctly](#1-ensuring-ec2-instances-can-serve-web-traffic-and-scale-correctly)
      - [**Objective**: Confirm that the EC2 instances behind the Auto Scaling Group (ASG) can serve web traffic and scale based on the load.](#objective-confirm-that-the-ec2-instances-behind-the-auto-scaling-group-asg-can-serve-web-traffic-and-scale-based-on-the-load)
      - [Expected Outcome:](#expected-outcome)
      - [Verification:](#verification)
    - [2. Verifying that the ALB Distributes Traffic Across Instances](#2-verifying-that-the-alb-distributes-traffic-across-instances)
      - [**Objective**: Ensure the ALB is correctly distributing incoming traffic across the available EC2 instances.](#objective-ensure-the-alb-is-correctly-distributing-incoming-traffic-across-the-available-ec2-instances)
      - [Expected Outcome:](#expected-outcome-1)
      - [Verification:](#verification-1)
    - [3. Checking that the RDS Instance Is Accessible from EC2 but Not from the Internet](#3-checking-that-the-rds-instance-is-accessible-from-ec2-but-not-from-the-internet)
      - [**Objective**: Validate that the RDS instance can be accessed only from the EC2 instances in the private subnet and that no direct access from the public internet is possible.](#objective-validate-that-the-rds-instance-can-be-accessed-only-from-the-ec2-instances-in-the-private-subnet-and-that-no-direct-access-from-the-public-internet-is-possible)
      - [Expected Outcome:](#expected-outcome-2)
      - [Verification:](#verification-2)
    - [4. Ensuring Static Assets Are Correctly Stored and Accessible from the S3 Bucket](#4-ensuring-static-assets-are-correctly-stored-and-accessible-from-the-s3-bucket)
      - [**Objective**: Verify that static assets are correctly stored in the S3 bucket and accessible publicly in read-only mode.](#objective-verify-that-static-assets-are-correctly-stored-in-the-s3-bucket-and-accessible-publicly-in-read-only-mode)
      - [Expected Outcome:](#expected-outcome-3)
      - [Verification:](#verification-3)
    - [6. Running TFsec to Check Security Compliance in Our Code](#6-running-tfsec-to-check-security-compliance-in-our-code)
    - [5. Troubleshooting Tips](#5-troubleshooting-tips)


## Modules Overview

### 1. PC Networking Module
   - Purpose: Creates a VPC, along with public and private subnets, routing tables, an Internet Gateway, and a NAT Gateway.
   - [Module](tf-modules/vpc-network/README.md)


### 2. EC2 Auto Scaling Group (ASG) Module
   - Purpose: Launches an EC2 Auto Scaling Group that scales based on CPU utilization. The instances are placed in the public subnets and serve traffic via an ALB.
   - [Module](tf-modules/ec2/README.md)

### 3. Application Load Balancer (ALB) Module
   - Purpose: Sets up an ALB to balance incoming HTTP/HTTPS traffic across the EC2 instances.
   - [Module](tf-modules/alb-http/README.md)

### 4. RDS Module
   - Purpose: Provisions a highly available RDS instance (PostgreSQL) in private subnets with a Multi-AZ setup.
   - [Module](tf-modules/rds/README.md)

### 5. S3 Bucket Module
   - Purpose: Creates an S3 bucket for storing static assets or backups.
   - [Module](tf-modules/s3-ro/README.md)

### 6. IAM Roles and Policies Module
   - Purpose: Provides IAM roles and policies with the least privilege principle. EC2 instances can access S3 and CloudWatch, and other AWS resources as needed.
   - [Module](tf-modules/iam/README.md)

### 7. Security Groups Module
   - Purpose: Configures security groups to control access between different resources like ALB, EC2, and RDS.
   - [Module](tf-modules/seg/README.md)




## Environment Setup

### 1. Prerequisites

- **Docker**: Ensure you have [Docker installed](https://docs.docker.com/engine/install/).
- **Docker Compose**: Ensure you have [Docker  compose installed](https://docs.docker.com/compose/).
- **AWS IAM User with the Necessary Permissions**: As outlined in the IAM policy section, ensure the user running Terraform has the necessary permissions.

### 2. Permissions for the Terraform User

To follow the principle of least privilege, the user that runs Terraform should only have the permissions necessary to create, manage, and destroy the resources in your AWS infrastructure.

You can create an IAM policy with the following permissions:

#### IAM Policy for Terraform User

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*",
        "iam:PassRole",
        "iam:GetRole",
        "iam:CreateRole",
        "iam:AttachRolePolicy",
        "iam:DetachRolePolicy",
        "iam:DeleteRole",
        "rds:*",
        "s3:*",
        "elasticloadbalancing:*",
        "autoscaling:*",
        "cloudwatch:*",
        "logs:*",
        "vpc:*",
        "route53:*"
      ],
      "Resource": "*"
    }
  ]
}
```


### 3. Environment Vars

To ensure Terraform manages your infrastructure correctly, you must define certain environment variables in a .env file. This file will be used by Docker Compose to load all necessary environment variables, ensuring proper functionality of the automation.

#### Example `.env` File:

```bash
#Set env
ENV=stg

#AWS config vars
AWS_ACCESS_KEY_ID=xxxxx
AWS_SECRET_ACCESS_KEY=xxxxx
AWS_DEFAULT_REGION=us-east-1

#Tf vars
TF_VAR_rds_db_username=xxxxx
TF_VAR_rds_db_password=xxxxx
TF_VAR_local_public_ip=x.x.x.x/32
TF_VAR_ssh_public_key="ssh-rsa xxxxx"

#Test vars
NUM_REQUESTS=10000
NUM_CONCURRENT=50
NUM_CURL_REQUESTS=20

```

##### Explanation of the Variables:

- **ENV**: Specifies the environment (`stg` for staging or `prod` for production).
- **AWS_ACCESS_KEY_ID**: Your AWS access key ID.
- **AWS_SECRET_ACCESS_KEY**: Your AWS secret access key.
- **AWS_DEFAULT_REGION**: The AWS region where the infrastructure will be deployed (e.g., `us-east-1`).
- **TF_VAR_local_public_ip**: Your local machine's public IP address, used for whitelisting in security groups.
- **TF_VAR_ssh_public_key**: The SSH public key used to access EC2 instances.
- **TF_VAR_rds_db_username**: Username for the RDS database administrator.
- **TF_VAR_rds_db_password**: Password for the RDS database administrator.
- **NUM_REQUESTS**: Number of requests sent to the ALB.
- **NUM_CONCURRENT**: Number of concurrent workers sending requests to the ALB.
- **NUM_CURL_REQUESTS**: Number of requests used to verify load balancing.

## How to Deploy, Update, and Destroy the Infrastructure

To simplify the infrastructure creation process with Terraform, i created a small automation using Docker. This setup allows for easy management of environments while securely maintaining AWS credentials, SSH keys, DB user&pass and personal IP addresses.

### 1. Deploy the Infrastructure

#### a. Setting Environment

The `tf-code/$ENV` folder contains the Terraform configurations for the `$ENV` environment. If we start with the `stg` environment, then to create a production environment, simply create a new folder named `tf-code/prod` and copy the configurations from the `stg` folder. Modify variables or resource names as needed to distinguish between environments.

#### b. Initialize Terraform

Set the environment variable according to the environment you want to work in, and remember to have created the folder (`tf-code/stg` or `tf-code/prod`):

```bash
make init
```

#### c. Validate the Terraform Plan

Run the following command to check plan of the infrastructure:

```bash
make plan
```

#### d. Apply the Terraform Plan

Run the following command to deploy the infrastructure:

```bash
make apply
```

Terraform will show you the planned infrastructure changes and proceed with the deployment.

### 2. Update the Infrastructure

If you need to update the infrastructure (e.g., change the number of instances in the ASG or modify security group rules or delete a resource):

#### a. Make the Necessary Changes

Edit the relevant `.tf` files in the `tf-code/stg` or `tf-code/prod` folder.

#### b. Apply the Changes

Once the changes are made, run the following command to update the infrastructure:

```bash
make apply
```

Terraform will detect the changes and apply them.

### 3. Destroy the Infrastructure

If you need to tear down the entire environment:

#### a. Run the Destroy Command

**CAUTION!** Terraform will destroy the infrastructure after executing the destroy command.

```bash
make destroy
```

### 4. Create Another Environment (e.g., `prod`)

#### a. Duplicate the `stg` Folder

To create another environment (e.g., production), simply duplicate the `tf-code/stg` folder and rename it to `tf-code/prod`.

```bash
cp -r tf-code/stg tf-code/prod
```

#### b. Update Variables for the New Environment

Modify variables in `tf-code/prod/` as needed (e.g., instance types, resource names, etc.) to distinguish between environments.

#### c. Update Enviroment Variables for the New Environment

Modify `ENV` variables in `.env` as needed (e.g.,  stg, prod, etc.) to distinguish between environments.

#### d. Deploy the New Environment

Follow the deployment steps (`make init` and `make apply`).
 

## Testing Plan for Infrastructure Setup

### 1. Ensuring EC2 Instances Can Serve Web Traffic and Scale Correctly

#### **Objective**: Confirm that the EC2 instances behind the Auto Scaling Group (ASG) can serve web traffic and scale based on the load.

For this challenge, I built a small script where I use Apache Benchmark (ab) to perform a basic load test on the EC2 instances and then validate that the load balancing is working correctly.

  1. Setup Test Suit:
	  - Set the environment variables in `.env` 
	  - NUM_REQUEST: Number of requests to send to the ALB
	  - NUM_CONCURRENT: Concurrency of the requests
	  - NUM_CURL_REQUESTS: Number of curl requests to validate that the load balancing is functioning correctly.
  2. Simulate Load to Test Auto Scalin:
   - Run test script
```bash
make test
```
   - Monitor the Auto Scaling Group (ASG) in the AWS Console or use **CloudWatch** to check if instances are scaling up/down based on CPU load.
#### Expected Outcome:
- Web traffic should be served by the EC2 instances via the ALB.
- The number of EC2 instances should scale based on the CPU utilization as defined in the ASG policy.
#### Verification:
- Use **CloudWatch** metrics to observe scaling activities.
- Check the **EC2 Instances** in the ASG to ensure they are increasing or decreasing as the load fluctuates.

### 2. Verifying that the ALB Distributes Traffic Across Instances
#### **Objective**: Ensure the ALB is correctly distributing incoming traffic across the available EC2 instances.

1. Test Load Distribution:
   - Using the script output from the previous step, observe whether the requests are hitting different EC2 instances by checking the **Hostname** in the output.

#### Expected Outcome:
- Requests should be evenly distributed across the EC2 instances.
- Logs should indicate that different instances are receiving requests as the ALB distributes traffic.

#### Verification:
- Check the output of the test script to ensure that each EC2 instance hostname is different, confirming traffic distribution.
- Use the **AWS Console** or **CloudWatch** to verify that traffic is being routed to multiple targets within the **ALB Target Group**.


### 3. Checking that the RDS Instance Is Accessible from EC2 but Not from the Internet

#### **Objective**: Validate that the RDS instance can be accessed only from the EC2 instances in the private subnet and that no direct access from the public internet is possible.

1. Test Access from EC2:
   - SSH into one of the EC2 instances.
   - Use a database client **psql** for PostgreSQL to connect to the RDS instance using the private endpoint.
   
   Example for PostgreSQL:
   ```bash
   psql -h <RDS-Endpoint> -U <db-username> -d <db-name>
   ```

2. Test Access from the Internet:
   - From a local machine or another instance not in the private subnet, try to access the RDS endpoint. This should be blocked by the **security group** that denies public access.
   
   Example (this should fail):
   ```bash
   psql -h <RDS-Endpoint> -U <db-username> -d <db-name>
   ```

#### Expected Outcome:
- EC2 instances should be able to access the RDS instance.
- Any attempt to connect to the RDS instance from the public internet should be denied.

#### Verification:
- Ensure successful connections to the RDS instance from EC2 instances.
- Verify failed connections from any external or public machine, ensuring the RDS instance is secure and not exposed to the internet.


### 4. Ensuring Static Assets Are Correctly Stored and Accessible from the S3 Bucket

#### **Objective**: Verify that static assets are correctly stored in the S3 bucket and accessible publicly in read-only mode.

1. Upload Static Assets:
   - Use the AWS CLI or the S3 Console to upload a few static files (e.g., images, HTML files) to the S3 bucket.
   
   Example CLI command:
   ```bash
   aws s3 cp ./my-static-file.jpg s3://<bucket-name>/my-static-file.jpg
   ```

2. Test Public Access:
   - Access the files publicly via the S3 URL to ensure they are accessible in read-only mode.
   
   Example:
   ```bash
   curl https://<bucket-name>.s3.amazonaws.com/my-static-file.jpg
   ```

3. Test Denied Actions:
   - Attempt to delete or upload files using a public access URL. This should be denied since the bucket only allows read access.

#### Expected Outcome:
- Static assets should be accessible publicly via the **S3 URL** in read-only mode.
- Any attempt to modify (upload/delete) objects via public access should be denied.

#### Verification:
- Ensure that files can be read from the S3 bucket publicly.
- Test actions such as file deletion or modification from a public endpoint, which should be denied.

### 6. Running TFsec to Check Security Compliance in Our Code

[Tfsec](https://github.com/aquasecurity/tfsec) is a tool that allows us to validate the security measures in our Infrastructure as Code (IaC). I have implemented a small test in our automation pipeline to check the security status of our code.

To run the test, simply execute the following command:

```bash
make sec
```

This will output the security status of our code and highlight any potential improvements we should make to ensure continuous compliance with best security practices.


### 5. Troubleshooting Tips
- Communication issue with ALB: You should verify that the health check of the ASG is functioning correctly. To do this, check the routing rules, security groups, etc.
- Instances unavailable or invalid: You can try changing the instance type you are using from EC2 or RDS to another one. Otherwise, you may need to wait for AWS to increase your quota before trying again.
- Permission errors when creating a resource: Check the role and permissions assigned to the Terraform user, and gradually escalate permissions until you find the one needed.
- Invalid SSH access to instances: Ensure that your SSH key is correct and has been added to your computer.
