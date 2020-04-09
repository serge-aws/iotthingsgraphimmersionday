#!/bin/bash
# This script initialises the setup for the immersiond ay on the Cloud9 EC2 instance
#Install jq
sudo yum -y install jq

#Install AWS IOT Devices Python SDK
sudo pip install AWSIoTPythonSDK



# update CLIs in user mode
curl -O https://bootstrap.pypa.io/get-pip.py
python get-pip.py --user
cp ~/.bash_profile toto
echo "export PATH=~/.local/bin:\$PATH" >> ~/.bash_profile
export PATH=~/.local/bin:$PATH
pip3 install awscli --upgrade --user
echo "AWS Version :"
aws --version
#pip3 install --upgrade --user awscli

#!/bin/bash
# This script  copies all necessary files for Immersion day user into their CLoud9 instance

# devices, and attaches an IoT policy to the certificates.

cd /home/ec2-user/environment
mkdir LAB1
for Item in customizefiles.sh cloudcamera.py cloudms.py cloudscreen.py deleteIotThings.sh provisionIotThings.sh PutDDBlambda.gql;
  do
    FILE_NAME=$Item
    # Copy File here
    aws s3 cp s3://iot-thingsgraph-immersionday-files/LAB1/$FILE_NAME /home/ec2-user/environment/LAB1
  done

mkdir LAB2

for Item in deleteIotThings.sh provisionIotThings.sh Button.py Camera.py   LED.py readGaugeLambda.py;

  do
    FILE_NAME=$Item
    # Copy File here
    aws s3 cp s3://iot-thingsgraph-immersionday-files/LAB2/$FILE_NAME /home/ec2-user/environment/LAB2
  done

#
# now load all required devices
#

cd /home/ec2-user/environment/LAB1
chmod +x *.sh
./provisionIotThings.sh

cd /home/ec2-user/environment/LAB2
chmod +x *.sh
./provisionIotThings.sh  
cd /home/ec2-user/environment/init_script


