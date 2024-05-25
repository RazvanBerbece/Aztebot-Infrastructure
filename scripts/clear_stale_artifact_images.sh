#
# Shared Script - GCP Artifact Registry Docker Image Cleaner
#
# RULE: Delete all unnecessary images such that for each image name there are at most 2-3 images stored at all times, 
# thus allowing rolling back at least 2-3 versions if needed.
#

# Variables
image_limit_per_service=1

previous_image_name=""
current_image_name=""
current_image_count=0

deleted_count=0

# Retrieve a list of all the published images and their metadata
current_header_count=0
gcloud artifacts docker images list europe-west2-docker.pkg.dev/aztebot-403621/aztebot-docker-ar | while read line 
do
    # Skip over header lines
    if (( current_header_count < 1 )); then
        current_header_count=$(( current_header_count+1 ))
        continue
    fi

    #
    # Now, each line is a published image containing the 4 metadata fields
    #

    # Tokenise the line by whitespace to separate the Docker image data
    read -ra image_metadata -d '' <<< "$line"

    # Capture the specific metadata values
    image_name=${image_metadata[0]}
    digest=${image_metadata[1]}
    created_at=${image_metadata[2]}
    updated_at=${image_metadata[3]}

    current_image_name=$image_name

    # If a previous image name exists
    if [ "$previous_image_name" != "" ]; then 
        # And it is the same as the image name in the current iteration (hence a duplicate)
        if [ "$current_image_name" = "$previous_image_name" ]; then 
            # And the number of duplicates for given image is already greater than the limit 
            if (( current_image_count >= image_limit_per_service )); then
                # Then delete the current digest
                deleted_count=$(( deleted_count+1 ))
                image_id="$current_image_name@$digest"
                echo "TO DELETE: $image_id"
                # gcloud artifacts docker images delete europe-west2-docker.pkg.dev/aztebot-403621/aztebot-docker-ar/IMAGE_NAME@DIGEST
            fi
        else
            # Moved from a service image to another (e.g. aztebot to aztemusic)
            current_image_count=0 # reset the current count for the new image name
        fi
    fi  

    current_image_count=$(( current_image_count+1 ))
    previous_image_name=$current_image_name

done

echo "Deleted a total of $deleted_count redundant Docker images."