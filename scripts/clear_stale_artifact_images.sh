# GCP Artifact Registry Docker Image Cleaner Shared Script
#
# RULE: Delete all unnecessary images such that for each image name there are at most 2-3 images stored at all times, 
# enabling rolling back at least 2-3 versions

# Variables
image_limit_per_service=3
final_digests=()

image_name_regex_pattern="^europe-west2-docker\.pkg\.dev/aztebot-403621/aztebot-docker-ar/([^/]+)$"
image_digest_regex_pattern="^(sha256:[a-f0-9]{64})$"

# Retrieve a list of all the published images and their metadata
count=0
gcloud artifacts docker images list europe-west2-docker.pkg.dev/aztebot-403621/aztebot-docker-ar | while read line 
do
    # Skip over header lines (command status row, empty line, field names row)
    if (( count < 3 )); then
        count=$(( count+1 ))
        continue
    fi

    # Now, each line is a published image containing the 4 metadata fields

    # Tokenise by whitespace to retrieve the 4 fields for each image row in the result
    read -ra image_metadata -d '' <<< "$line"

    image_name=${image_metadata[0]}
    digest=${image_metadata[1]}
    created_at=${image_metadata[2]}
    updated_at=${image_metadata[3]}

    echo $image_name, $digest
done