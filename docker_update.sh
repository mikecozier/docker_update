#!/bin/bash

LOG_FILE="/var/log/docker_update.log"
TO_EMAIL="example@hotmail.com"
SUBJECT="Docker Update Notification"
echo "Starting Docker update check at $(date)" >> $LOG_FILE

# Get a list of all running containers
containers=$(docker ps --format "{{.Names}}")

for container in $containers; do
    echo "Checking for updates for container: $container" >> $LOG_FILE
    
    # Get the image name used by the container
    image=$(docker inspect --format "{{.Config.Image}}" $container)
    echo "Current image: $image" >> $LOG_FILE
    
    # Pull the latest image
    echo "Pulling the latest image for $image" >> $LOG_FILE
    docker pull $image

    # Get the latest image ID and current running image ID
    latest_image=$(docker inspect --format "{{.Id}}" $image)
    running_image=$(docker inspect --format "{{.Image}}" $container)

    if [ "$latest_image" != "$running_image" ]; then
        echo "Update found for $container. Restarting..." >> $LOG_FILE
        
        # Stop and remove the old container
        docker stop $container
        docker rm $container
        
        # Recreate the container with the same name and image
        docker run -d --name $container $image
        echo "Updated and restarted $container" >> $LOG_FILE
        
        # Send email notification using mutt
        echo -e "The container '$container' was updated to the latest version." | mutt -F /home/usernamehere/mail/.muttrc -s "$SUBJECT" -- "$TO_EMAIL"
        
        echo "Email notification sent for $container update" >> $LOG_FILE
    else
        echo "No update available for $container" >> $LOG_FILE
    fi
done

echo "Docker update check completed at $(date)" >> $LOG_FILE
