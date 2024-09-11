# Task1

## Table of Contents
- [Task1](#task1)
  - [Table of Contents](#table-of-contents)
  - [Task 1: High-Level Architecture](#task-1-high-level-architecture)
    - [1. High-Level Architecture Diagram](#1-high-level-architecture-diagram)
      - [Explanation of Components:](#explanation-of-components)
      - [Cost-Effectiveness Contributions:](#cost-effectiveness-contributions)
      - [Trade-offs Between Cost and Performance:](#trade-offs-between-cost-and-performance)
    - [2. Load Balancing and Auto-Scaling Strategies](#2-load-balancing-and-auto-scaling-strategies)
      - [AWS Services Utilized:](#aws-services-utilized)
      - [Minimizing cost while maintaining availability:](#minimizing-cost-while-maintaining-availability)
      - [Cost Implications:](#cost-implications)
    - [3. Security and Compliance Considerations](#3-security-and-compliance-considerations)
      - [Security Measures:](#security-measures)
      - [Cost Implications:](#cost-implications-1)
      - [Balance of Security and Cost-Effectiveness:](#balance-of-security-and-cost-effectiveness)

---

## Task 1: High-Level Architecture

### 1. High-Level Architecture Diagram

There are two main approaches for front-end architecture in a web application: Server-Side Rendering (SSR) and Single-Page Application (SPA). In the SSR approach, the server handles rendering dynamic HTML, which improves SEO and initial performance but requires more compute resources, increasing costs. On the other hand, the SPA approach shifts the workload to the client, allowing static content to be hosted on storage solutions like S3 and distributed globally via a CDN like CloudFront, optimizing costs and enhancing speed. The choice between these approaches depends on the application’s needs in terms of performance, SEO, and scalability.

- **Diagram with SSR**: 
![Link to SSR Architecture](../diagrams/task1-ssr.png)
- **Diagram with SPA**: 
![Link to SPA Architecture](../diagrams/task1-spa.png)

#### Explanation of Components:
Each component in the architecture diagram is selected based on performance, cost-effectiveness, and scalability. Below is a breakdown of each component and why it was chosen:

- **Amazon ECS with Fargate**: A serverless container orchestration platform that runs containers without needing to manage servers. Fargate provides cost optimization by automatically scaling the required compute resources, ensuring pay-for-use, while also offering built-in security and isolation.

- **Amazon RDS MySQL with Standby Replica in Another AZ**: A managed MySQL database service designed for high availability and disaster recovery by automatically replicating data to a standby instance in a different Availability Zone (AZ). This ensures minimal downtime and enhances data durability, while optimizing cost through automated backups and on-demand scaling.

- **Amazon S3 for Static Website Content**: Provides durable and cost-effective storage for static web assets, such as images and JavaScript files, reducing the need for more expensive compute resources. Leveraging S3's high availability and regional redundancy ensures secure and scalable content delivery.

- **Amazon S3 Glacier for Database Backups**: Utilized for the automated backup storage of RDS MySQL databases, providing highly durable and secure long-term storage. Lifecycle policies are configured to optimize and reduce storage costs over time, while ensuring reliable and efficient data recovery in case of failure.

- **Amazon Elastic Container Registry**: A fully managed Docker container registry that integrates with ECS to store and manage container images. ECR optimizes costs by charging only for the storage and data transferred, while ensuring high security with IAM-based access controls.
  
- **Security Groups**: Virtual firewalls configured to tightly control inbound and outbound traffic to resources. By adhering to least-privilege principles, security groups ensure a secure environment while allowing flexibility and scalability.
  
- **IAM (Identity and Access Management)**: Used to enforce strict access controls across AWS resources, ensuring that only authorized entities can access sensitive data or make changes. This helps to minimize security risks while enabling efficient management of permissions at no additional cost.

- **AWS Certificate Manager (ACM)**: Simplifies the management and deployment of SSL/TLS certificates, ensuring that all public-facing endpoints are secured without incurring additional certificate costs. ACM automates certificate renewal, reducing the operational burden while enhancing security.

- **AWS Secrets Manager**: A managed service used to securely store, manage, and rotate sensitive information, such as database credentials, API keys, and other secrets. Secrets Manager integrates with backend and frontend services to provide secure access to sensitive data as needed, ensuring that these secrets are encrypted and automatically rotated to maintain security. This reduces the operational overhead of managing secrets while adhering to security best practices.
  
- **Amazon CloudWatch**: A monitoring service that tracks resource usage and performance metrics, enabling fine-tuning of infrastructure to optimize cost and performance. CloudWatch provides automated alerts and dashboards for real-time insights, helping to maintain availability and security.

- **AWS CloudTrail**: Logs and monitors API activity across AWS resources, ensuring full visibility into actions taken within the infrastructure. CloudTrail aids in compliance and forensic investigations, helping to secure the environment without adding complexity or cost overhead.

- **Application Load Balancer for Frontend and Backend**: ALB distributes traffic across multiple targets, ensuring high availability and scalability. A public-facing ALB is used for the frontend, while a private ALB secures backend services, optimizing network segmentation and reducing costs by minimizing unnecessary public exposure.

- **NAT Gateway**: Enables instances in private subnets to securely access the internet for software updates or external API calls, while preventing inbound traffic. Configured to minimize data transfer costs by strategically placing it in high-traffic AZs.

- **Amazon CloudFront for Frontend SPA**: A global content delivery network (CDN) that reduces latency and optimizes the delivery of static assets for the frontend SPA. CloudFront helps in lowering bandwidth costs while ensuring secure and fast content delivery through integrated SSL and edge caching.

- **Internet Gateway**: Is essential for enabling internet connectivity for resources in public subnets, ensuring that your backend and frontend services can interact with external systems when necessary.

- **Virtual Private Cloud**: Provides full control over the networking environment, including IP address ranges, subnets, routing tables, and gateways. It serves as the foundational networking layer for the infrastructure, ensuring that both public and private resources are segregated and secure.

- **Private Subnet**: A subnet within the VPC that is isolated from direct internet access, used for backend golang service and  database. Resources in a private subnet interact with the internet through a NAT Gateway for outbound requests while remaining secure from inbound traffic, ensuring cost-effectiveness and high security.

- **Public Subnet**: A subnet that allows direct internet access through an Internet Gateway (IGW). It would be used for frontend web servers or load balancers. Security groups ensure that only authorized traffic reaches the public resources, maintaining security.

#### Cost-Effectiveness Contributions:

- ECS Fargate: Optimizes costs by eliminating the need to manage servers and charges only for the compute resources actually used.
- RDS: Being fully managed, it reduces operational and maintenance costs, with the added benefit of automatic scaling.
- ALB: Enhances availability and stability while reducing costs by balancing traffic across multiple instances.
- S3 for static assets: Provides a low-cost, scalable storage solution, ideal for static files, especially when combined with CloudFront.
- CloudFront for SPA: Speeds up content delivery globally and reduces the load on backend servers, further optimizing costs.
  
#### Trade-offs Between Cost and Performance:
- Use ECS Fargate instances instead of EC2 or EKS to reduce costs by paying only for the resources used and saving on management overhead.
- Use Fargate spot instances if you need to reduce costs even further.
- ECS Fargate is advantageous because the Docker container gives us more flexibility if we later want to migrate the solution to a container orchestrator. However, if we wanted to optimize costs to the maximum, I would use AWS Lambda instead.
- Having a single database instance in one availability zone (AZ) reduces costs, although it may lead to downtime if that AZ becomes unavailable.
- Use S3 Glacier for database backups and apply a lifecycle policy with the minimum retention time to optimize costs, knowing that it may take longer to retrieve the data.
- Setting aggressive Fargate scaling policies (e.g., minimizing the number of running instances) could quickly affect performance if there are constant traffic spikes.
- Using a single availability zone reduces network costs at the expense of losing high availability in case of a failure.
  
---

### 2. Load Balancing and Auto-Scaling Strategies

The Application Load Balancer (ALB) will distribute traffic evenly among all running ECS instances, while Fargate will handle scaling based on both the incoming traffic and metrics such as CPU and memory utilization.

- **Diagram**: 
- ![Link to Load Balancing and Auto-Scaling Diagram](../diagrams/task1-alb.png)

#### AWS Services Utilized:
- **Application Load Balancer (ALB)**: For distributing incoming traffic across multiple ECS instances to ensure high availability.
- **Fargate**: To dynamically scale ECS instances based on traffic and demand, ensuring cost-efficiency.

#### Minimizing cost while maintaining availability:

- Maintain one instance in each Availability Zone (AZ) to ensure the application’s availability at all times, both for the backend and frontend.
- Based on peak hours, define the optimal number of instances that can handle the load (using historical metrics, load testing, etc.).
- Scale up instances if CPU or memory usage remains above 80% for more than 5 minutes.
- Scale down instances if CPU or memory usage stays at 20% or lower for more than 10 minutes.
- Scaling should add or remove one instance at a time to control costs without sacrificing availability.
- Define efficient load balancing rules based on paths.
  
#### Cost Implications:
- Maintaining 2 instances in each Availability Zone creates a constant cost that could be avoided by sacrificing availability, as there would be a delay if no instances were present.
- Optimizing scaling metrics during peak demand hours will significantly help in reducing costs.
- Having controlled scaling will help keep costs under control, as only the necessary instances will be created without over-provisioning the infrastructure.

---

### 3. Security and Compliance Considerations

Security is a fundamental part of any system. For our proposal, we will have the following components to ensure data protection measures are met at all times.

#### Security Measures:
- VPCs with Subnets: Segregation of public and private subnets to ensure that critical infrastructure is not exposed to the internet. The backend and RDS database are isolated from public access.
- Security Groups: Configured to restrict traffic to only the necessary CIDRs and ports. The frontend only receives traffic from the public ALB, the backend only receives traffic from the private ALB and is allowed to send traffic to the RDS. The RDS only allows traffic from the backend ECS instances.
- IAM Roles and Policies: Least privilege access control is enforced to ensure minimal attack surface on all resources. For example:
  - ECS instances should have a role that only allows them to access secrets, the S3 bucket, and CloudWatch for logging events.
  - S3 buckets should have all public access restricted and only be accessible by the resources that require it.
- ALB with Certificate Manager: A TLS certificate is created to encrypt all traffic in transit across the entire architecture.
- ECS Instances: ECS instances have disk encryption enabled to ensure encryption of data at rest, as well as for RDS instances.
- S3 Buckets: S3 buckets have encryption keys enabled to securely store all contents.
- Secrets Manager: Used to encrypt and securely store all the secrets required by the frontend and backend applications.
- NAT Gateway that secures all outbound traffic through a single point.
- Routing tables implemented as a security measure to ensure that only traffic from known and trusted sources is allowed within the network. 
  

#### Cost Implications:
In general, using all these resources within AWS would not significantly increase the cost of our infrastructure, except for the following exceptions:

- The number of secrets stored in Secrets Manager.
- The amount of outbound traffic through the NAT Gateway.
- If we were to use TLS certificates not issued by AWS.

#### Balance of Security and Cost-Effectiveness:

The cost of balancing security is not always convenient, as a single security breach could lead to much higher associated costs than maintaining preventive measures. In my opinion, considering the low cost of these security measures within AWS, I wouldn’t discard any of them. However, I would consider adding more layers of security, such as a WAF before the ALB, to prevent DDoS attacks.
