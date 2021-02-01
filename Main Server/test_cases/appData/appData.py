from user.user import Url,token
import requests
import json
from typing import List



def addTank(deviceID : str,fishNames : List[str],fish_count : List[int],height : int , length : int , width : int,authorization : str):
    
    
    """data = dict()
    data["device_id"] = deviceID
    data["fish_names"] = fishNames
    data["fish_count"] = fish_count
    data["height"] = height
    data["lenght"] = length
    data["width"] = width"""
    
    data = {  "device_id" : deviceID,
    "fish_names" :fishNames,
    "fish_count" :fish_count,
    "height" :height,
    "lenght" :length,
    "width" :width}
    
    token = authorization
    headers={'Authorization':token}
    
    url=Url+"app/addtank"
    
    r = requests.post(url, data=json.dumps(data),headers=headers)

    if(r.status_code == 200):
        print("adding tank is success")
        token = r.headers['Authorization']
        print(r.json)
        return True
    elif (r.status_code==406):
        print("Incorrect tank id ")
        return False
    elif (r.status_code==401):
        print("Authorization error")
        return False
    elif (r.status_code==422):
        print("validation error")
        return False
    else:
        print("adding tank failed")
        return False
        

def retriveTankData(email : str ,deviceId :str ,day : str ,authorization : str):
    
    data = {"email": email, "device_id": deviceId ,"day" :day}
    
    token = authorization
    headers={'Authorization':token}
    
    url=Url+"app/retrivedata"
    
    r = requests.post(url, data=json.dumps(data),headers=headers)

    if(r.status_code == 200):
        print("retrive tank data  is success")
        token = r.headers['Authorization']
        print(r.json)
        return True
    elif (r.status_code==401):
        print("Authorization error")
        return False
    elif (r.status_code==422):
        print("Authorization error")
        return False
    else:
        print("retrive tank data failed")
        return False
        
def retriveDeviceData(email : str ,authorization : str):
    
    data = {"email": email}
    
    token = authorization
    headers={'Authorization':token}
    
    url=Url+"app/getdevicedata"
    
    r = requests.post(url, data=json.dumps(data),headers=headers)

    if(r.status == 200):
        print("retrive device data  is success")
        token = r.headers['Authorization']
        print(r.json)
        return True
    elif (r.status_code==401):
        print("Authorization error")
        return False
    elif (r.status_code==422):
        print("Authorization error")
        return False
    elif (r.status_code==406):
        print("wrong email")
        return False
    else:
        print("retrive device data failed")
        return False



