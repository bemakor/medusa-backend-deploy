#!/bin/bash

IMAGE_TAG=$1

# IMAGE UPDATER
echo "Updating ecs.tf with the new image tag: $IMAGE_TAG"
sed -i "s|image\s*=\s*\".*\"|image = \"$IMAGE_TAG\"|" terraform/ecs.tf

echo "ecs.tf file updated successfully with image tag: $IMAGE_TAG"

# FORCE DEPLOYMENT NEW TASK
echo "Forcing a new deployment of the ECS service..."
aws ecs update-service \
  --cluster medusa-cluster \
  --service medusa-service \
  --force-new-deployment
echo "ECS service updated successfully."