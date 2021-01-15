from fastapi import Body,Response

from Server import app
from Server.db.schemas.userschema import DeviceNotification
from Server.controllers.notificationController import notificationSend


@app.post("/tankapi/error")
async def errorNotification(response:Response,body:DeviceNotification=Body(...)):
    await notificationSend(body.device_id,body.msg)
    return {}
    

@app.post("/tankapi/data")
async def getData():
    return {}