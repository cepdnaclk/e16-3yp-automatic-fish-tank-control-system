from fastapi import Body,Response

from Server import app
from Server.db.schemas.userschema import DeviceNotification,DeviceData
from Server.controllers.notificationController import notificationSend
from Server.db.controllers.influxHandlers import storeData


@app.post("/tankapi/error")
async def errorNotification(response:Response,body:DeviceNotification=Body(...)):
    await notificationSend(body.id,body.msg)
    return {"s":1}
    

@app.post("/tankapi/data")
async def getData(body:DeviceData=Body(...)):
    result=await storeData(body.id,body.ph,body.temp)
    if result:
        return {"s":1}
    return {"s":0}


@app.post("/tankapi/temp")
async def getTemperature():
    # implement to send initial temp to controller
    return{}