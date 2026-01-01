#!/bin/bash

<< task
Depoly a django app and handle the code for errors
task

code_clone(){
        echo " cloning django app...."
        git clone https://github.com/LondheShubham153/django-notes-app.git
}

install_requirements(){
        echo "Installing dependencies..."
        sudo apt-get install docker.io nginx -y
}

required_restart(){
        sudo chown $USER /var/run/docker.sock
        sudo systemctl enable docker
        sudo systemctl enable nginx
        sudo systemctl restart docker
}

deploy(){
        docker build -t notes-app .
        docker run -d -p 8000:8000 notes-app:latest
}

echo "*************DEPLOYMENT STARTED**********************"
echo "*** Cloning code***"
if ! code_clone; then
        echo "the code directory already exist"
        cd django-notes-app
fi
echo "***Installing Requirements***"
if ! install_requirements; then
        echo "Installation failed"
        exit 1
fi
if ! required_restart; then
        echo "System fault identified"
        exit 1
fi
echo "***Resatrting required tools***"

if ! deploy; then
        echo "Deployement failed, Sending mail to admin"
        # send mail
        exit 1
fi
echo "*************DEPLOYMENT DONE*************************"
