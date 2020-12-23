
#!/bin/bash
DATE=$(date +%Y-%m-%d-%H:%M)

# Getting all volumes with tag Production
vol_id=$( aws ec2 describe-volumes --filters "Name=attachment.status, Values=attached" "Name=attachment.delete-on-termination,Values=false" \
        --query 'Volumes[].Attachments[].VolumeId' --output text)

##Checking if volume list is empty
if [ -z "$vol_id" ]
then
   echo "There is no volume with such tag"
   exit 1
fi

# Iterating each volume
        for i in $vol_id
        do
           #Getting each instance id associated with that volume
           inst_id=$(aws ec2 describe-volumes --volume-ids $i --query 'Volumes[].Attachments[].InstanceId' --output text)

           #Checking the state of the above instance
           state=$(aws ec2 describe-instances --instance-ids $inst_id  --query 'Reservations[].Instances[].State[].Name' --output text)

           if [ $state = 'running' ]
           then
                #Getting Instance Name
                inst_name=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$inst_id" "Name=key,Values=Name" --query 'Tags[].Value' --output text)
                echo "$inst_name"
				#Getting volume block
                block=$(aws ec2 describe-volumes --volume-ids $i --query 'Volumes[].Attachments[].Device'  --output text)
                echo "$block"
				#Creating snapshot
                snapid=$(aws ec2 create-snapshot --volume-id $i --query 'SnapshotId' --description  "New Automated-SnapShot-$inst_name-$block-$DATE" --output text)
				echo "$snapid"
                if [ $? == 0 ]
                then
                    echo $block | grep sda1
                    if [ $? == 0 ]
                    then
                    aws ec2 create-tags --resources $snapid --tags Key=Name,Value="$inst_name-root-disk" --output text
                    else
                    aws ec2 create-tags --resources $snapid --tags Key=Name,Value="$inst_name-secondary-disk" --output text
                    fi

	  	        else
                    echo "Snapshots creation error !! ....Please Check and Resolve"
			    fi

            else
     		echo "stopped instance $inst_id"
	fi
        done

  echo "====================================Job executed successfully================================"