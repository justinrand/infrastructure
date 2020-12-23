#!/bin/bash

# VOLUMES=`aws ec2 describe-volumes | jq -r '.Volumes[].Attachments[] | select( .DeleteOnTermination == false) | .VolumeId'`

VOLUMES=`aws ec2 describe-volumes | jq -r '.Volumes[] | select( .Attachments[].DeleteOnTermination == false) | \
    {Name: (.Tags[]|select(.Key=="Name")|.Value), VolumeId: (.Attachments[].VolumeId) }'`

names=$(echo $VOLUMES | jq -r .Name)
volumeids=$(echo $VOLUMES | jq -r .VolumeId)
echo $names
echo $volumeids
exit

for v in $(echo $VOLUMES | jq -r '.[]'); do
    echo $v
    # NAME=`(echo $v | jq .Name)`
    # echo $NAME
    # aws ec2 describe-volumes --volume-ids $v
done
