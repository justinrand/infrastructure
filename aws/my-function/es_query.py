import requests
import os

URL = "https://api.github.com/repos/justinrand/infrastructure/issues/1/comments"
USER = "justinrand"
PASSWORD = os.environ['token']

def issue_comment(event, context):

    comment = {
        "body": body
    }
    #r = requests.get(url = URL, json=query)
    r = requests.post(url = URL, json=comment, auth=(USER,PASSWORD))

    data = r.json()

    print(data)
