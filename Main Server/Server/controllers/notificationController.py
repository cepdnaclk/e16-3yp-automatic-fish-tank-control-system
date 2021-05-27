import requests
from Server.mqtt.publishHandler import publishMessage
from Server.controllers import send_msg_chat_api_url
from Server.db.controllers.phoneHandlers import getPhoneNumber

def sendMessage(reciverNumber,msg,send_msg_chat_api_url):
    payload = {"phone": reciverNumber, "body": msg}
    r = requests.post(send_msg_chat_api_url, data=payload)
    if r.status_code==200:
      return True
    return False

async def notificationSend(device_id:str,msg:str):
    phoneNumber=await getPhoneNumber(device_id)
    phoneNumber=phoneNumber.strip()
    phoneNumber="94"+phoneNumber[1:]
    body=""
    if msg=="1":
        body="There is an error in tank {"+device_id+"} check the temperature value"   
    elif msg=="2":
        body="There is an error in tank {"+device_id+"} check the Ph value"
    elif msg=="3":
        body="There is an error in tank {"+device_id+"} check your system"
    sendMessage(phoneNumber,body,send_msg_chat_api_url)