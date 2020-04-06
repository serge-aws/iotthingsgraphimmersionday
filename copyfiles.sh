#!/bin/bash
# This script initialises the setup for the immersiond ay on the Cloud9 EC2 instance
#Install jq
sudo yum -y install jq

#Install AWS IOT Devices Python SDK
sudo pip install AWSIoTPythonSDK


#!/bin/bash
# This script  copies all necessary files for Immersion day user into their CLoud9 instance

# devices, and attaches an IoT policy to the certificates.

cd /home/ec2-user/environment
mkdir LAB1
for Item in cloudcamera.py cloudms.py cloudscreen.py deleteIotThings.sh provisionIotThings.sh PutDDBlambda.gql;
  do
    FILE_NAME=$Item
    # Copy File here
    aws s3 cp s3://iot-thingsgraph-immersionday-files/LAB1/$FILE_NAME /home/ec2-user/environment/LAB1
  done

mkdir LAB2

for Item in provisionIotThings.sh ACTION_activity.gql ACTION_finished.gql Button.py Camera.py EVENT_activity.gql EVENT_finished.gql LAMBDA_activity.gql LAMBDA_finished.gql LED.py labFlow.gql readGaugeLambda.py;

  do
    FILE_NAME=$Item
    # Copy File here
    aws s3 cp s3://iot-thingsgraph-immersionday-files/LAB2/$FILE_NAME /home/ec2-user/environment/LAB2
  done


