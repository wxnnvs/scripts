#!/bin/bash

if [ "$1" == "--remove" ]; then
    rm -rf upload
    echo "Removed 'upload' folder."
else
    # Check if the 'upload' folder exists
    if [ ! -d "upload" ]; then
        mkdir upload
        cd upload
    fi

    cd upload

    # Download the files
    echo "Downloading files..."
    curl -O https://raw.githubusercontent.com/wxnnvs/upload/refs/heads/dev/app.js > /dev/null 2>&1
    curl -O https://raw.githubusercontent.com/wxnnvs/upload/refs/heads/dev/package.json > /dev/null 2>&1
    curl -O https://raw.githubusercontent.com/wxnnvs/upload/refs/heads/dev/package-lock.json > /dev/null 2>&1

    # Install the dependencies
    echo "Installing dependencies..."
    npm install > /dev/null 2>&1

    # Run the application
    while true; do
        node app.js
        echo "Restarting in 5 seconds..."
        sleep 5
    done
fi
