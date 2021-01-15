from Server import app
from fastapi import Header
from typing import Optional

from Server.controllers.tokenControllers import token_check

@app.get("/control/feed")
async def feed(Authorization:Optional[str] = Header(None)):
    user=await token_check(Authorization)
    return user
    
    
@app.get("/control/renew")
async def renewWater(Authorization:Optional[str] = Header(None)):
    user=await token_check(Authorization)
    return user
    