import requests
from requests_toolbelt.adapters import host_header_ssl
import boto3
import os
import sys

URL = "https://api.github.com/repos/justinrand/infrastructure/issues/1/comments"
USER = "justinrand"
# PASSWORD = os.environ['tokenCode']

def issue_comment(event, context):

    comment = {
        # "body": os.environ["body"]
    }
    #r = requests.get(url = URL, json=query)
    s = requests.Session()
    s.mount('https://', host_header_ssl.HostHeaderSSLAdapter())
    # r = s.get("https://93.184.216.34")
    r = s.get("https://93.184.216.34", headers={"Host": "example.org"})
    # r = requests.post(url = URL, json=comment, auth=(USER,PASSWORD))

    # data = r.json()

    print(r.status_code)
    print(r.text)

    print("Python version:")
    print(sys.version)
    print("hello world")

if __name__ == "__main__":
    issue_comment('','')