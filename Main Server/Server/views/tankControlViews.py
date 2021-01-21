from fastapi import Header, Body, HTTPException, status
from typing import Optional

from Server import app
from Server.controllers.tokenControllers import token_check
from Server.mqtt.publishHandler import publishMessage
from Server.db.schemas.userschema import Device


@app.post("/control/feed")
async def feed(Authorization: Optional[str] = Header(None), body: Device = Body(...)):
    user = await token_check(Authorization)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Authorization Error",
            headers={"WWW-Authenticate": "Bearer"},
        )
    try:
        topic = "tank/"+body.device_id
        publishMessage(topic, "feed", 2)
        return {"status": True}
    except:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )


@app.post("/control/renew")
async def renewWater(Authorization: Optional[str] = Header(None), body: Device = Body(...)):
    user = await token_check(Authorization)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Authorization Error",
            headers={"WWW-Authenticate": "Bearer"},
        )
    try:
        topic = "tank/"+body.device_id
        publishMessage(topic, "renw", 2)
        return {"status": True}
    except:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
