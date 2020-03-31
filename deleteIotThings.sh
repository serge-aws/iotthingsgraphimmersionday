#!/bin/bash
# This script deletes the IoT Core resources that were created during IoT320 
# workshop session
POLICY_NAME=IOT320DevicePolicy
for Item in motionSensor1 screen1 camera1 button RedLED GreenLED camera;
  do
    THING_NAME=$Item

    CERTIFICATE_ARN=$(aws iot list-thing-principals --thing-name $Item | jq -r ".principals[0]")
    aws iot detach-thing-principal --thing-name $Item --principal $CERTIFICATE_ARN
    CERTIFICATE_ID=$(echo $CERTIFICATE_ARN | cut -d'/' -f 2)
    aws iot update-certificate --certificate-id $CERTIFICATE_ID --new-status INACTIVE
    aws iot detach-principal-policy --policy-name $POLICY_NAME --principal $CERTIFICATE_ARN
    aws iot delete-certificate --certificate-id $CERTIFICATE_ID
    aws iot delete-thing --thing-name $Item
  done
    