import boto3
import json
import os
import requests

filename='resp.pem'

def lambda_function(event, context):
    URL='http://cdp.thawte.com/ThawteRSACA2018.crl'

    print('requesting')
    with requests.get(URL, stream=True) as r:
        r.raise_for_status()
        with open(filename, 'wb') as f:
            for chunk in r.iter_content(chunk_size=8192):
                f.write(chunk)

    print('done')
    print('uploading')
    s3 = boto3.resource('s3')
    object = s3.Object('jrand-test-bucket', 'mycrl.pem')
    object.put(Body=open(filename, 'rb'))

if __name__ == "__main__":
    lambda_function('','')