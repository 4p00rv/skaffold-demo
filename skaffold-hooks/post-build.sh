#! /bin/bash
#set -x
set -e

echo Copying image to k3s cluster
mkdir -p /tmp/skaffold
# Replace special chars in Image because docker doesn't support importing
# to file with chars `/` or `:`
IMG_TAG=$(docker image inspect $SKAFFOLD_IMAGE | jq -r .[].Id | awk -F":" '{print $2}')
IMG_NAME=$(echo $SKAFFOLD_IMAGE | awk -F":" '{print $1}')
IMG_NAME_CLEAN=$(echo $IMG_NAME |  sed 's/[\/]/-/g')
FILE_NAME="/tmp/skaffold/${IMG_NAME_CLEAN}-${IMG_TAG}.tar"
docker image save -o "$FILE_NAME" ${IMG_NAME}:${IMG_TAG}
# Check if ctr (containerd) command line tool is available
if [ ! -z "$(command -v ctr)" ]; then
  echo Importing image to containerd
  ctr image import $FILE_NAME
fi
echo Done. Cleaning up 
if [ -f $FILE_NAME ]; then
  rm $FILE_NAME
fi

