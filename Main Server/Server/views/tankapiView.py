from fastapi import Body,Response

from Server import app
from Server.db.controllers.influxHandlers import storeData
from Server.db.schemas.userschema import DeviceNotification,DeviceData,Device
from Server.controllers.notificationController import notificationSend
from Server.controllers.algorithmController import findFishTankTemperature,findFeedingAmount



@app.post("/tankapi/error")
async def errorNotification(response:Response,body:DeviceNotification=Body(...)):
    await notificationSend(body.id,body.msg)
    return {"s":1}
    

@app.post("/tankapi/data")
async def getData(body:DeviceData=Body(...)):
    result=await storeData(body.id,body.ph,body.tmp)
    if result:
        return {"s":1}
    return {"s":0}


@app.post("/tankapi/feedtime")
async def getFeedTime(body:Device=Body(...)):
    feed_amount= await findFeedingAmount(body.device_id)
    return{"s":str(feed_amount)}

@app.post("/tankapi/temp")
async def getTemperature(body:Device=Body(...)):
    temperature=await findFishTankTemperature(body.device_id)
    return{"s":str(temperature)}