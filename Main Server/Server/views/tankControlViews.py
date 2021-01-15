from fastapi import Header,Body
from typing import Optional

from Server import app
from Server.controllers.tokenControllers import token_check
from Server.mqtt.publishHandler import publishMessage
from Server.db.schemas.userschema import Device


@app.post("/control/feed")
async def feed(Authorization:Optional[str] = Header(None),body:Device=Body(...)):
    user=await token_check(Authorization)
    if not user:
        return {"status": False}
    try:
        topic="tank/"+body.device_id
        publishMessage(topic,"feed",2)
        return {"status": True}
    except :
        return {"status": False}
    
    
    
@app.post("/control/renew")
async def renewWater(Authorization:Optional[str] = Header(None),body:Device=Body(...)):
    user=await token_check(Authorization)
    if not user:
        return {"status": False}
    try:
        topic="tank/"+body.device_id
        publishMessage(topic,"renw",2)
        return {"status": True}
    except :
        return {"status": False}
    