#!/bin/bash

#
# Shared Script - GCP Artifact Registry Docker Image Cleaner
#
# RULE
# Delete all unnecessary images such that for each image name there are at most 2-3 images stored at all times, 
# thus allowing rolling back at least 2-3 versions if needed.
#
# USAGE
# Run clear_stale_artifact_images.sh <ARG_DRY_RUN>
# Examples: clear_stale_artifact_images.sh 1 (for a dry-run)
#           clear_stale_artifact_images.sh 0 (for an actual run)
#

# Input Arguments
dry_run=$1 # 0=false (submit deletion requests), 1=true (don't perform any deletions)

# Variables
image_limit_per_service=3

previous_image_name=""
current_image_name=""
current_image_count=0

deleted_count=0

if [[ $# -eq 0 ]] ; then
    echo "No arguments provided. Using default values (dry_run: true)."
    dry_run=1
fi

# Announce purpose of run (dry-run or actual run)
if (( dry_run == 1 )); then
    echo "Note that this is a dry-run and that no resources will be deleted."
else
    echo "Note that this is an actual workflow execution and that resources *may* be deleted."
fi

# Retrieve a list of all the published images and their metadata
artifact_registry_result_lines=$(gcloud artifacts docker images list europe-west2-docker.pkg.dev/aztebot-403621/aztebot-docker-ar)

current_header_count=0
while read line; do

    # Skip over header lines
    if (( current_header_count < 1 )); then
        current_header_count=$(( current_header_count+1 ))
        continue
    fi

    #
    # Now, each line of text contains data about a published Docker image (i.e the 4 returned data fields per row)
    #

    # Tokenise the line by whitespace to separate the Docker image data on the input line
    read -ra image_metadata -d '' <<< "$line"

    # Capture the specific metadata values
    image_name=${image_metadata[0]}
    digest=${image_metadata[1]}
    # created_at=${image_metadata[2]}
    # updated_at=${image_metadata[3]}

    # Image names tend to be grouped in the responses from GCP (i.e similar names come one after the other)
    # so it makes sense to 
    current_image_name=$image_name

    # If a previous image name exists
    if [ "$previous_image_name" != "" ]; then 
        # And it is the same as the image name in the current iteration (hence a duplicate)
        if [ "$current_image_name" = "$previous_image_name" ]; then 
            # And the number of duplicates for given image is already greater than the limit 
            if (( current_image_count >= image_limit_per_service )); then
                # Then delete the current published image given its ID (name & digest hash)
                image_id="$current_image_name@$digest"
                # Only send delete requests if NOT in a dry-run
                if (( dry_run == 0 )); then
                    res=$(gcloud artifacts docker images delete $image_id --async --quiet --delete-tags)
                fi
                deleted_count=$(( deleted_count+1 ))
                echo "Marked for deletion: $image_id"
            fi
        else
            # Moved from a service image to another (e.g. aztebot to aztemusic)
            current_image_count=0 # reset the current count for the new image name
        fi
    fi  

    current_image_count=$(( current_image_count+1 ))
    previous_image_name=$current_image_name

done <<< "$artifact_registry_result_lines"

# Announce workflow status at script completion time
echo "Submitted a total of $deleted_count redundant Docker images for deletion."
if (( dry_run == 0 )); then
    echo "Check the operation status in Artifact Registry (https://console.cloud.google.com/artifacts?cloudshell=true&project=aztebot-403621)."
else
    echo "Dry-run complete. No resources were deleted in GCP."
fi