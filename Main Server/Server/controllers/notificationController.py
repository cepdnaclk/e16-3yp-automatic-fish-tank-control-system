from Server.mqtt.publishHandler import publishMessage

async def notificationSend(device_id:str,msg:str):
    topic="app/"+device_id
    if msg=="1":
        publishMessage(topic,"There is some error in your tank Temperature",2)
    elif msg=="2":
        publishMessage(topic,"There is some error in your tank Ph value",2)
    elif msg=="3":
        publishMessage(topic,"There is some error in your tank system",2)
