# Decisions made in the design, challenges encountered, and potential future improvements for this challenge.

## Decisions made in the design
The designs were inspired by two frontend approaches that I have most commonly encountered in my experience: Server-Side Rendering (SSR) and Single Page Applications (SPA). The goal was to create a design that is not only robust but also scalable, secure, and, above all, cost-effective.

In my view, there are always opportunities to optimize both cost and security by exploring solutions beyond the native tools provided by cloud platforms. For architectures that involve more complex services, Kubernetes is a strong option, offering scalability, security, and high availability. Additionally, managed databases—whether provisioned by the cloud provider or installed on virtual machines and configured by tools like Ansible—can be considered. However, this comes with additional management overhead, which may not always be cost-effective.

For any architecture, balancing the benefits of managed services versus custom implementations is key to maintaining control over both cost and operational complexity. Choosing the right approach depends on the specific needs of the project and the available resources.

## Challenges encountered

The biggest challenge for me was researching and understanding the available AWS resources, as I had limited experience with this cloud provider. While the underlying logic and resources across different clouds are quite similar, each provider has its own specific configurations, resource types, and security rules that must be mastered. Designing and building everything outlined in this project has truly tested my abilities.

Another layer of complexity was added by constructing the entire project in English, which, while exciting, made the challenge even more demanding (with a little help from AI, of course :D).

Networking in AWS was another significant hurdle, as understanding how these concepts work is essential for securely connecting all the components of the project. Although I haven’t fully mastered it yet, I am confident that I’ll improve as I continue learning.

Additionally, serverless technologies have never been my strong suit. Most of my cloud experience has been with Kubernetes, where cost optimization is focused more on node-level and resource allocation for workloads. In my career, I’ve been fortunate to work on projects with enough resources to build all the necessary infrastructure. I now see expanding my knowledge of serverless and FinOps as crucial areas for growth in my professional development.

## Future improvements for this challenge

- Creating more comprehensive test cases for the infrastructure using tools like **Goss** to ensure all components are functioning as expected.
- Expanding my AWS knowledge to develop more detailed and efficient architectural diagrams, with a stronger focus on cloud resources, cost optimization, and overall efficiency.
- Revisiting task 1 with a proposal that incorporates Kubernetes, Prometheus, Grafana, OpenTelemetry, managed databases on EC2, service mesh, WAF, and other advanced cloud technologies.
- Enhancing the security of the infrastructure by enabling TLS for all traffic through the load balancer, securing the S3 bucket with encryption, enabling HTTPS on the Nginx server managing requests on EC2 instances, and implementing more granular network access controls using ACLs.

