#!/bin/bash

BUCKET_NAME=jrand-test-bucket
BUILD_FILE_URI=build-info.json

aws s3 cp s3://${BUCKET_NAME}/${BUILD_FILE_URI} build_info.json
BUILD=$( cat build_info.json | jq -r .build )

echo $BUILD