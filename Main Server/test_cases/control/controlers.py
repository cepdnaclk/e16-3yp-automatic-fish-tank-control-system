import requests
import json

from user.user import Url,token


def feed(device_id:str,authorization : str):
    data = {
        "device_id": device_id
    }
    token = authorization
    url=Url+"control/feed"
    headers={'Authorization':token}
    r = requests.post(url, data=json.dumps(data),headers=headers)

    if(r.status == 200):
        print("feed control  signaling sucess")
        token = r.headers['Authorization']
        print(r.json)
        return True
    elif (r.status_code==422):
        print("Validation error")
        return False
    elif (r.status_code==401):
        print("Authorization error")
        return False
    elif (r.status_code==500):
        print("Incorrect username or password")
        return False
    else:
        print("feed control signaling failed")
        return False
    

def renew(device_id:str,authorization : str):
    data = {
        "device_id": device_id
    }
    token = authorization
    headers={'Authorization':token}
    url=Url+"control/renew"
    r = requests.post(url, data=json.dumps(data),headers=headers)

    if(r.status == 200):
        print("Renew water control signaling sucess")
        token = r.headers['Authorization']
        print(r.json)
        return False
    elif (r.status_code==422):
        print("Validation error")
        return False
    elif (r.status_code==401):
        print("Authorization error")
        return False
    elif (r.status_code==500):
        print("Incorrect username or password")
        return False
    else:
        print("Renew water control signaling failed")
        return False