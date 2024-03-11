#!/bin/bash

## Script to Convert GP2 volumes to GP3
# Authors: Sibi Jose
# Redux
# Date: 11 Mar 2024

# Set AWS region
AWS_REGION="us-east-1"

# Select the AWS profile/account
PROFILE="logoup-prod" #logoup-stage logoup-accounting logoup-shared

# List all volumes using gp2
gp2_volumes=$(aws --profile $PROFILE ec2 describe-volumes --query 'Volumes[?VolumeType==`gp2`].VolumeId' --output text --region $AWS_REGION)

# Loop through each volume and modify its type to gp3
for volume_id in $gp2_volumes; do
    echo "Converting volume $volume_id from gp2 to gp3..."
    aws --profile $PROFILE ec2 modify-volume --volume-id $volume_id --volume-type gp3 --region $AWS_REGION
    echo "Conversion of volume $volume_id completed."
done

echo "All gp2 volumes converted to gp3."
