import requests
import json

from test_cases.user.user import Url,token


def feed(device_id:str):
    data = {
        "device_id": device_id
    }
    headers={'Authorization':token}
    r = requests.post(login_url, data=json.dumps(data),headers=headers)

    if(r.status == 200):
        print("feed control  signaling sucess")
        token = r.headers['Authorization']
        print(r.json)
    else:
        print("feed control signaling failed")
    

def renew(device_id:str):
    data = {
        "device_id": device_id
    }
    headers={'Authorization':token}
    r = requests.post(login_url, data=json.dumps(data),headers=headers)

    if(r.status == 200):
        print("Renew water control signaling sucess")
        token = r.headers['Authorization']
        print(r.json)
    else:
        print("Renew water control signaling failed")