#!/bin/bash
# This script created 3 IoT devices, provisions an X.509 certificate for those
# devices, and attaches an IoT policy to the certificates.
#Install jq
#sudo yum -y install jq

#Install AWS IOT Devices Python SDK
#sudo pip install AWSIoTPythonSDK

#Download Amazon RootCA
curl -o rootCA.crt https://www.amazontrust.com/repository/AmazonRootCA1.pem

# create an IoT security policy
POLICY_NAME=IOT320DevicePolicy

for Item in motionSensor1 screen1 camera1 button RedLED GreenLED camera;
  do
    THING_NAME=$Item

    # create thing in the IoT registry
    aws iot create-thing --thing-name $THING_NAME

    # create X.509 key and certificate for the device and activate the device
    aws iot create-keys-and-certificate --set-as-active \
      --public-key-outfile $THING_NAME.public.key \
      --private-key-outfile $THING_NAME.private.key \
      --certificate-pem-outfile $THING_NAME.certificate.pem >  /tmp/create_cert_and_keys_response

    # save values from the previous call for using in later commands    
    CERTIFICATE_ARN=$(jq -r ".certificateArn" /tmp/create_cert_and_keys_response)
    CERTIFICATE_ID=$(jq -r ".certificateId" /tmp/create_cert_and_keys_response)
    

        # attach IoT security policy to certificate
    aws iot attach-policy --policy-name $POLICY_NAME --target $CERTIFICATE_ARN

    # attach the certificate to the thing
    aws iot attach-thing-principal --thing-name $THING_NAME --principal $CERTIFICATE_ARN
        echo "Registered thing $THING_NAME"
  done


