#!/bin/bash
# This script deletes the IoT Core resources that were created during IoT320 
# workshop session
cd /home/ec2-user/environment/LAB1
chmod +x *.sh
./deleteIotThings.sh
cd /home/ec2-user/environment/LAB2
chmod +x *.sh
./deleteIotThings.sh
cd /home/ec2-user/environment/init_script
