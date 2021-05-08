import requests
import json
from requests_toolbelt.adapters import host_header_ssl
import os
import sys
import boto3
from git import Repo
import shutil
from operator import itemgetter

git_url = "git@github.com:justinrand/infrastructure.git"
repo_dir = "/tmp/my-infr"
bucket_name = "jrand-test-bucket"
ami_file = "latest_ami.txt"
USER = "justinrand"
PASSWORD = os.environ['tokenCode']

def lambda_handler(event, context):
    latestTag = getTag()
    readFileFromS3()
    print("Latest tag is", latestTag)
    getLatestAMI()
    return 0
    # envs=['dev', 'dev-i', 'devops', 'int', 'test', 'prod']
    envs_to_build = os.environ['envs'].split()
    print(envs_to_build)

    BASE_URL=os.environ['URL']
    s = requests.session()
    s.mount('https://', host_header_ssl.HostHeaderSSLAdapter())
    # r = s.get("https://93.184.216.34", headers={"Host": "example.org"})
    # r = s.post(url = URL, auth=(USER,PASSWORD))

    print(r.status_code)
    print(r.text)

    for x in envs_to_build:
        print("Starting job for " + x)

def getTag():
    repo = Repo.clone_from(git_url, repo_dir, branch='main')
    tags = sorted(repo.tags, key=lambda t: t.commit.committed_datetime)
    # cleanup
    shutil.rmtree(repo_dir)
    return tags[-1]

def getFileFromS3():
    s3 = boto3.resource('s3')
    obj = s3.Object(Bucket=bucket,Key=ami_file)

    with open('/tmp/temp_file.txt', 'wb') as data:
        obj.download_fileobj(data)


def readFileFromS3():
    s3 = boto3.resource('s3')
    obj = s3.Object(bucket_name,ami_file)
    # rstrip removes carriage return
    body = obj.get()['Body'].read().decode('utf-8').rstrip()
    print(body)

def getLatestAMI():
    ec2 = boto3.client('ec2', region_name='us-east-2')
    images = ec2.describe_images(
        Owners=['amazon'],
        Filters=[
            {
                'Name': 'description',
                'Values': [
                    'Amazon Linux AMI*'
                ],
                'Name': 'name',
                'Values': [
                    'amzn2-ami-hvm-2*'
                ]
            }
        ]
    )
    latest_ami = sorted(images['Images'],key=itemgetter('CreationDate'))
    ami_id = latest_ami[-1]['ImageId']
    print(ami_id)


if __name__ == "__main__":
    lambda_handler('','')