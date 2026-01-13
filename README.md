# Scalable Node.js Web Application on Azure using Terraform

This project demonstrates how to deploy a scalable, production-style web application on **Microsoft Azure** using **Terraform**.  
The infrastructure includes networking, security, and compute resources, all defined as code.  


**Components:**

- **Terraform:** Infrastructure as code tool managing all Azure resources.
- **Azure Virtual Network (VNet) and Subnet:** Isolate resources and manage network traffic.
- **Network Security Group (NSG):** Firewall that allows HTTP traffic only on port 80.
- **VM Scale Set (VMSS):** Ensures high availability, scalability, and consistent configuration of multiple Linux VMs.
- **Node.js Web Application:** Serves HTTP requests, demonstrating a real-world workload.
  

## Technologies Used

- Terraform for IaC  
- Microsoft Azure cloud platform  
- Azure VM Scale Sets for scalable compute  
- Azure Networking (VNet, Subnet, NSG)  
- Linux (Ubuntu) as the operating system  
- Node.js for the web application
  

## How It Works

1. Terraform provisions networking (VNet, Subnet) and security (NSG).  
2. VM Scale Set is created with Linux instances.  
3. Each VM installs Node.js and starts the web application automatically using startup scripts.  
4. Public traffic is routed through NSG rules to the VM instances.  
5. The application is accessible via a public IP.


## Deployment Instructions
To deploy the project, ensure that you have the **Azure CLI configured and authenticated**. Then run: 
   
    terraform init
    terraform plan
    terraform apply


## Accessing the Application
After deployment, you can access the live application at: http://108.143.65.125/




