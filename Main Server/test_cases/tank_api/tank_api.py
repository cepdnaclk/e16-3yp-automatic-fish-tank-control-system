import requests
import json

from test_cases.user.user import Url


def sendErrorFromMicroController(id: str, msg: str):
    data = {
        "id": id,
        "msg": msg
    }
    url = Url+"tankapi/error"
    r = requests.post(url, data=json.dumps(data))

    if(r.status == 200):
        print("Error control  signaling sucess")
        print(r.json)
    else:
        print(r.json)
        print("Error control signaling failed")


def sendDataFromMicroController(id: str, ph: str, tmp: str):
    data = {
        "id": id,
        "ph": ph,
        "tmp": tmp
    }

    url = Url+"tankapi/data"
    r = requests.post(url, data=json.dumps(data))

    if(r.status == 200):
        print("Data sending sucess")
        print(r.json)
    else:
        print(r.json)
        print("Data sending failed")


def getFeedTimeFromServer(device_id:str):
    data = {
        "device_id": device_id
    }
    
    url=Url+"tankapi/feedtime"
    r = requests.post(url, data=json.dumps(data))
    
    if(r.status == 200):
        print("Get feeding time  sucess")
        print(r.json)
    else:
        print(r.json)
        print("Get feeding time failed")



def getTempFromServer(device_id:str):
    data = {
        "device_id": device_id
    }
    
    url=Url+"tankapi/temp"
    r = requests.post(url, data=json.dumps(data))
    
    if(r.status == 200):
        print("Get temperature  sucess")
        print(r.json)
    else:
        print(r.json)
        print("Get temperature failed")
