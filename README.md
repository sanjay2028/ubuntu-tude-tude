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



