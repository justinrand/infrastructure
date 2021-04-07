import requests
import json
from requests_toolbelt.adapters import host_header_ssl
import os
import sys

def lambda_handler(event, context):
    # envs=['dev', 'dev-i', 'devops', 'int', 'test', 'prod']
    envs_to_build = os.environ['envs'].split()
    print(envs_to_build)
    # print("Received event: " + json.dumps(event, indent=2))
    BASE_URL=os.environ['URL']
    s = requests.session()
    s.mount('https://', host_header_ssl.HostHeaderSSLAdapter())
    # r = s.get("https://93.184.216.34", headers={"Host": "example.org"})
    # r = requests.post(url = URL, json=comment, auth=(USER,PASSWORD))

    for x in envs_to_build:
        print("Starting job for " + x)


if __name__ == "__main__":
    lambda_handler('','')