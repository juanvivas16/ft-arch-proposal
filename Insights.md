### Decisions made in the design, challenges encountered, and potential future improvements for this challenge.

## Decisions made in the design
The designs were based on the two frontend approaches I have seen most commonly used in my experience: SSR (Server-Side Rendering) and SPA (Single Page Application). The goal was always to create a robust but simple design that is scalable, secure, and above all, cost-effective.

In my opinion, there are always opportunities to improve cost and security by looking beyond the cloud provider's native tools. For more complex architectures involving many services, one could consider using Kubernetes, which offers scalability, security, and high availability. Likewise, managed databases (those installed on a VM and configured by us through Ansible, for example) could also be considered, assuming the additional management cost, which is not always low.

## Challenges encountered
The biggest challenge was researching and understanding the available resources in AWS since I have had very little experience with this cloud provider. While the logic and resources between clouds are quite similar, there are always configurations, resource types, and security rules that need to be mastered. It has truly been a great challenge for me to design and build everything outlined in this project.

Additionally, constructing all of this in English added another layer of excitement and difficulty to the challenge (with a little help from AI, of course :D).

Understanding how networking concepts work in AWS was another major challenge since this is essential for securely connecting everything I have built for the project. I don’t fully master it yet, but I hope to get there soon!

Serverless has never been my strong suit in general, as my experience in the cloud world has mostly been with Kubernetes. This experience has led me to think about cost optimization more at the node and workload resource level. In my professional journey, I have also had the advantage of working on projects with sufficient resources to create all the necessary infrastructure. I consider improving my knowledge in serverless and FinOps to be a key area for growth in my career.

## Future improvements for this challenge
A list of improvements I plan to make includes:
- Creating better test cases for the infrastructure, using tools like **Goss**, for example.
- Enhancing my AWS knowledge to propose more in-depth diagrams with a better understanding of cloud resources, costs, and efficiency.
- Reworking task 1 with a proposal that includes Kubernetes, Prometheus, Grafana, OpenTelemetry, managed databases on EC2, service mesh, WAF, etc.