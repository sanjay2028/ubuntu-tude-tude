# Information for Terraform Assignment Tute Dude
This project contains the CI/CD Pipeline for a front end and back end app.
Ref: Tute Dude / DevOps Course / CI/CD Deployment Assignment


---------
## PART 1

# Deploy Flask and Express on a Single EC2 Instance

**Instance Setup**
1. Start a Virtual Machine in your cloud
1. SSH into your VM and run setup.sh. This will install all the required packages.
1. Generate SSH keys using ssh-keygen to establish ssh communication between your server and github. 

**Directory Setup**
1. Add a new group call tutedudeapp. (You can choose any name of your choice)
1. Add the group to both your user as wel as to jenkins user. 
    -   sudo usermod -aG tutedudeapp $USER
    -   sudo usermod -aG tutedudeapp jenkins
1. Setup your work directory as /var/app
1. You must set the required permissions to /var/app/
    - sudo chown -R jenkins:tutedudeapp /var/app
    - sudo chmod -R 2775 /var/app 
1. By setting ownership and permission, the permision will be prevailed to the directories and subdirectories. 

**Backend Setup**
1. Clone your repo for backend in /var/app/backend
1. install dependencies and ensure your app is up and running. 
1. Since the flaskap will be restarted later by jenkins, start you backend app by creating a service in /etc/systemd/system/flaskapp.service.
1. Refer to flaskapp.service file for more details
1. Start your service using following commands
    - sudo systemctl start flaskapp // to start the app
    - sudo systemctl enable flaskapp // to ensure it resumes after system restart
1. Test your app by logging on to http://your-app-id:5000/heartbeat
1. If the app is up, you will get 200 OK status and OK response in JSON

**Frontend Setup**
1. Clone your repo for backend in /var/app/frontend
1. install dependencies and ensure your app is up and running. 
1. Start your front end app using
    - pm2 start index.js --name frontend
1. Test your app by logging on to http://your-app-id:9000
1. If the app is up, you will see the registration page of Node App

## PART 2

# SETUP Jenkins Pipeline. 
1. Jenkins has already been setup using setup.sh
1. Create two declarative pipelines
    - Flask-Backend
    - Node-Frontend
1. Jenkinsfile for each pipeline is provided in the repository
    - Frontend Jenkinsfile
        jenkins/frontend/Jenkinsfile
    - Backend Jenkinsfile
        jenkins/backend/Jenkinsfile
1. For each pipeline, under Triggers, ensure **GitHub hook trigger for GITScm polling** is checked. 
1. This is required for webhook to trigger the builds for our pipelines automatically
1. Since we are uisng SSH for repository cloning, ensure you add github credentials in your Jenkins
    Jenkins > Manage Jenkins > Credentials > Global > Add credentials
    - Scope : Global
    - ID: github-ssh
    - Description: Anything of your choise
    - Username: git
    - Private Key (Enter Directory): Paste your private key here that we generated in **Instance Setup** step no 3. 

# Github Setup.
1. Ensure that your ssh key is deployed in your github settings to facilitate the ssh communication between your server and github. 
1. Under webhooks, also enable the webhook using your VM's Ip address. 
1. update the Payload URL as http://your-ip-address:8080/github-webhook
1. Once setup, after every code push, the webhook will be triggered and the code will be deployed.

## Additional setup for starting the front-end app using jenkins
1. Switch user to root using sudo su root
1. Switch the user to jenkins
1. navigate to /var/app/frontend
1. execute pm2 start index.js --name frontend

Since Jenkins will be responsible to restart the app, this step will prevent you from pm2 related failures during job execution. 

CICD setup is complete and you should be able to deploy your code through automated pipelines now.