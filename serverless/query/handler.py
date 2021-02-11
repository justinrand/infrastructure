import requests
import os

URL = "https://api.github.com/repos/justinrand/infrastructure/issues/1/comments"
USER = "justinrand"
PASSWORD = os.environ['tokenCode']

def issue_comment(event, context):

    comment = {
        "body": os.environ["body"]
    }
    #r = requests.get(url = URL, json=query)
    r = requests.post(url = URL, json=comment, auth=(USER,PASSWORD))

    data = r.json()

    print(data)

if __name__ == "__main__":
    issue_comment('','')