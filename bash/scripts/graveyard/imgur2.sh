#!/bin/bash
# Dependencies: fdupes
#
# This is a script I made to download all images in
# an imgur album. May need to be changed in the future.
# Example: ./imgurAlbumDownload.sh 3BBMp j6dac AZHdc

INPUT="$@"
REMOVEDUPES=true

# Test to see if fdupes works when REMOVEDUPES is
# set to true.  If it does not, then exit prematurely
if [ "$REMOVEDUPES" = true ]
then
    if ! [ -x "$(which fdupes)" ]
    then
        echo "ERROR: fdupes is not installed or executable.  Exiting now."
        exit
    fi
fi

# Adds new album URLs to a persistant text file
# This makes it easy for running more than once
for ALBUM in $INPUT
do
    if ! grep -q "http://imgur.com/a/$ALBUM" ./.imgurAlbums.txt
    then
        echo "Placing $ALBUM in .imgurAlbums.txt"
        echo "http://imgur.com/a/$ALBUM" >> ./.imgurAlbums.txt
    else
        echo "$ALBUM already exists in .imgurAlbums.txt"
    fi
done

# Iterate through each argument, so multiple albums
# can be downloaded with a single command
for ALBUM in $(sort ./.imgurAlbums.txt | cut -d \/ -f5 | uniq)
do
    # Make directory for destination of the images
    mkdir -p ./"$ALBUM"
    echo "Updating album $ALBUM"
    # Move to album directory
    cd ./"$ALBUM"
    # Fetch imgur album source for processing
    wget -q -O - "http://imgur.com/a/$ALBUM" |
    # Scrap HTML source for image tags
    grep "<img id=\"thumb-" |
    # Extract the URL in the source
    cut -d \" -f10 |
    # Extract the image name in the URL
    cut -d \/ -f4 |
    # Remove 's' in name to get full resolution version of image
    sed -e "s|s.jpg|.jpg|g" -e "s|s.png|.png|g" -e "s|s.gif|.gif|g" |
    # Sort image names
    sort |
    # Begin downloading images in the album
    while read IMAGE
    do
        # Tests to see if link hasn't already been downloaded
        # Quite useful for saving precious time and bandwidth
        if ! grep -q "http://i.imgur.com/$IMAGE" ./.imgurlinks.txt
        then
            # Indicate that new image is attempting to be downloaded
            echo -n "Downloading image $IMAGE for album $ALBUM .."
            # Fetch image, but checks if there is an image by the same name anyway
            wget -q -c "http://i.imgur.com/$IMAGE"
            # Indicate that the image has been downloaded
            echo ".. Finished"
            # Write URL to file for quick checking when script is ran again
            echo "http://i.imgur.com/$IMAGE" >> ./.imgurlinks.txt
        else
            echo "Already downloaded $IMAGE for album $ALBUM"
        fi
    done

    if [ "$REMOVEDUPES" = true ]
    then
        if [ -x "$(which fdupes)" ]
        then
            echo "Looking for duplicates in album $ALBUM"
            yes 1 | fdupes -rd .
            echo "Deduplication finished for album $ALBUM"
        else
            echo "ERROR: fdupes is not available for removing duplicates"
        fi
    fi
    echo "Update for album $ALBUM complete."
    cd -
    echo
done

echo "Update complete!"