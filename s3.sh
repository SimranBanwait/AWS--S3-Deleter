#!/bin/bash

# Check if buckets.txt exists
if [ ! -f "buckets.txt" ]; then
    echo "Error: buckets.txt file not found"
    exit 1
fi

# Read bucket names from buckets.txt and delete each bucket
while IFS= read -r bucket_name || [[ -n "$bucket_name" ]]; do
    if [ -n "$bucket_name" ]; then
        echo "Deleting bucket: $bucket_name"

        # Remove all objects from the bucket
        aws s3 rm s3://$bucket_name --recursive

        # Delete the bucket
        aws s3 rb s3://$bucket_name

        if [ $? -eq 0 ]; then
            echo "Successfully deleted bucket: $bucket_name"
        else
            echo "Failed to delete bucket: $bucket_name"
        fi
    fi
done < "buckets.txt"
