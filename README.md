# Information for Docker Assignment Tute Dude
This project contains the infrastructure for a microservice based architecture.

Directory Terraform:
Clone the repository and check for terraform directory. 
It contains three directories in the name of tasks

---------
## Task 1

Task-1 directory is a terraform project that provisions the following
1. VPC
2. Subnets (Public & Private)
3. Routing Table
4. Internget Gateway
5. Association of Public Subnet and Internet Gateway with route table. 
6. Security Groups
7. An EC2 instance that hosts both Backend and Frontend
8. A user_data has been provided for ec2 instance to install required softwares at the time of instance provision

**How to use task 1:**
switch to task-2 directory and look for examples.tfvars and update your desired values in it. 
Execute (in sequence)
    - terraform init
    - terraform plan
    - terraform apply

If all the commands are executed successfully, it will deploy the required infrastructure for task 1.
You can now configure your front end and backend instances. 

---------
## Task 2

Task-2 directory is a terraform project that provisions the following
1. VPC
2. Subnets (Public & Private)
3. Routing Table
4. Internget Gateway
5. Association of Public Subnet and Internet Gateway with route table. 
6. Security Groups
7. Two EC2 instances
    - One for backend
    - One for frontend
8. A user_data has been provided for ec2 instance to install required softwares at the time of instance provision

How to use task 2:
switch to task-2 directory and look for examples.tfvars and update your desired values in it. 
Execute (in sequence)
    - terraform init
    - terraform plan
    - terraform apply

---------
## Task 3

**Task-3 directory is a terraform project that provisions the following**

1. VPC
2. Subnets (Public)
3. Routing Table
4. Internget Gateway
5. Association of Public Subnet and Internet Gateway with route table. 
6. An applicaiton Load Balancer (ALB)
7. Target group for ALB
8. Listener for ALB and Target group created
9. Security Groups for ALB
10. Security Group for ECS Task
11. ECR Repository for front end
12. ECR Repository for back end. 

**How to use task 3:**
switch to task-2 directory and look for examples.tfvars and update your desired values in it. 
Execute (in sequence)
    - terraform init
    - terraform plan
    - terraform apply

If all the commands are executed successfully, it will deploy the required infrastructure for task 1.

Image creations for back end and front end
- Create backend image usign Dockerfile-backend provided in aws-assignment directory
    docker build . -t <your-preferred-tag> -f ./Dockerfile-backend

- Create frontend image usign Dockerfile-frontend provided in aws-assignment directory
    docker build . -t <your-preferred-tag> -f ./Dockerfile-frontend

Before pushing the images to repository, ensure you are logged in to ECR. You may use the following command to login:

aws ecr get-login-password --region "Your-AWS-region" | docker login --username AWS --password-stdin <AWS.Account.ID>.dkr.ecr.<AWS-REGION>.amazon.aws.com

Once login is successded, you may push the images to ECR using following command
docker push <tag name with ECR URL>

**Service Creation**
    - You must create a task definition before spinning up a service
    - Create a service from AWS Console. 
    - Select the task definition and it's version and configure the rest of the details as per your choise
    - create the service and wait until the service is up and running.