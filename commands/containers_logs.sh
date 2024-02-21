#!/bin/bash

# Function to recursively find docker-compose.yml files
find_docker_compose_files() {
    find "$1" -type f -name "docker-compose.yml"
}

# Main script
containers_logs() {
    # Specify the starting directory for the search
    start_directory="/DockerLNMP"
    
    # Find all docker-compose.yml files
    compose_files=($(find_docker_compose_files "$start_directory"))
    
    # Check if any files were found
    if [ ${#compose_files[@]} -eq 0 ]; then
        echo "No docker-compose.yml files found."
        exit 1
    fi
    
    # Iterate through the found files and execute docker-compose logs
    for file in "${compose_files[@]}"; do
        # Get the directory containing the docker-compose.yml file
        directory=$(dirname "$file")
        
        echo "Entering directory: $directory"
        cd "$directory" || exit 1
        
        # Execute docker-compose logs
        docker-compose logs
        
        echo "Exited directory: $directory"
    done
}

# Run the main function
containers_logs