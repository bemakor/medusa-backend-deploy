#!/bin/bash

IMAGE_TAG=$1

# Find and replace the image tag in the ecs.tf file
echo "Updating ecs.tf with the new image tag: $IMAGE_TAG"
sed -i "s|image\s*=\s*\".*\"|image = \"$IMAGE_TAG\"|" terraform/ecs.tf

echo "ecs.tf file updated successfully with image tag: $IMAGE_TAG"
