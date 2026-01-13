    Scalable Node.js Web Application on Azure using Terraform

This project demonstrates how to deploy a scalable, production-style web application on Microsoft Azure using Terraform. 
The infrastructure includes networking, security, and compute resources, all defined as code. 

    Architecture

The system follows a three-layer architecture:
User
 ↓
Public IP / Load Balancer
 ↓
Network Security Group (HTTP 80)
 ↓
Virtual Network (VNet) → Subnet
 ↓
Virtual Machine Scale Set (VMSS)
 ↓
Node.js Application


-Terraform: 
   An infrastructure as code tool managing all Azure resources.
-Azure Virtual Network (VNet) and Subnet: 
   Isolate resources and manage network traffic.
-Network Security Group (NSG): 
   Firewall that allows HTTP traffic only on port 80.
-VM Scale Set (VMSS): 
   Ensures high availability, scalability, and consistent configuration of multiple Linux VMs.
-Node.js Web Application: 
   Serves HTTP requests, demonstrating a real-world workload.

    Technologies Used

-Terraform for IaC
-Microsoft Azure cloud platform
-Azure VM Scale Sets for scalable compute
-Azure Networking (VNet, Subnet, NSG)
-Linux (Ubuntu) as the operating system
-Node.js for the web application

    How It Works

Terraform provisions networking (VNet, Subnet) and security (NSG).
VM Scale Set is created with Linux instances.
Each VM installs Node.js and starts the web application automatically using startup scripts.
Public traffic is routed through NSG rules to the VM instances.
The application is accessible via a public IP.

    Deployment Instructions

To deploy the project, ensure you have the Azure CLI configured and authenticated. Then run:

terraform init
terraform plan
terraform apply

Terraform will create all resources automatically. No manual VM configuration is needed.

    Accessing the Application

After deployment, you can access the live application at:
    http://108.143.65.125/

    <img width="1301" height="760" alt="image" src="https://github.com/user-attachments/assets/74c20e07-0048-43d3-a8b8-849460623981" />

    <img width="1300" height="612" alt="image" src="https://github.com/user-attachments/assets/ecb53239-a55e-497b-8b22-54d63606f8bf" />




