#!/bin/bash

# Save the current directory
current_dir=$(pwd)

# Clone remote repository
git clone https://github.com/Sam-Mey/DockerLNMP.git tmp_DockerLNMP

# Switch to the DockerLNMP directory
cd /DockerLNMP || exit

# Pull the latest changes from the remote warehouse
git fetch --quiet origin

# Reset the local repository to the latest commit
git reset --quiet --hard origin/main

# Add execution permissions to all .sh files
find . -name "*.sh" -exec chmod +x {} \;

# Create a symbolic link so that the 'dlnmp' command points to menu.sh
ln -sf "/DockerLNMP/menu.sh" "/usr/local/bin/dlnmp"

# Replace the files in the current directory with the latest content
rsync -av --exclude='.git' tmp_DockerLNMP/ .

# Switch back to the original directory
cd "$current_dir" || exit

# Clean up the temporary directory
rm -rf tmp_DockerLNMP

# Run the 'dlnmp' command (make sure 'dlnmp' has been set before this step)
dlnmp

# debug
# echo "Cloning the repository..."
# echo "Fetching the latest changes..."
# echo "Resetting local repository to the latest commit..."
# echo "Adding execute permissions to .sh files..."
# echo "Creating symbolic link for menu.sh..."
# echo "Replacing current content with updated content..."
# echo "Cleaning up temporary directory..."
# echo "Running 'et' command..."
