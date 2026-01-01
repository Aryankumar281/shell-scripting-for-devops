#!/bin/bash
<< comment
#this is used to create single user at a time
read -p "Enter username : " username

echo "You entered $username"

sudo useradd -m $username

echo "New user with name $username is added"
comment


