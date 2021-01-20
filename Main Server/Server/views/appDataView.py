from fastapi import Body,Header
from typing import Optional


from Server import app
from Server.db.schemas.userschema import AddTank,RetriveData,AppData
from Server.db.controllers.tankHandlers import addNewTank
from Server.db.controllers.influxHandlers import retriveData
from Server.db.controllers.appHandlers import getAppData


@app.post("/app/addtank")
async def addTank(Authorization:Optional[str] = Header(None),body:AddTank=Body(...)):
    user=await token_check(Authorization)
    if not user:
        return {"status": False}
    tank=dict()
    tank["device_id"]=body.device_id
    tank["fish_names"]=body.fish_names
    tank["fish_count"]=body.fish_count
    tank["height"]=body.height
    tank["lenght"]=body.lenght
    tank["width"]=body.width
    if (await addNewTank(tank,body.email)):
        return{"status":True}
    return{"status":False}
    
    
@app.post("/app/retrivedata")
async def retriveTankData(Authorization:Optional[str] = Header(None),body:RetriveData=Body(...)):
    user=await token_check(Authorization)
    if not user:
        return {"status": False}
    
    data=await retriveData(body.device_id,body.day)
    return {"status":True,"data":data}
    
    
    
@app.post("/app/getdevicedata")
async def retriveDevicesData(Authorization:Optional[str] = Header(None),body:AppData=Body(...)):
    user=await token_check(Authorization)
    if not user:
        return {"status": False}
    data=await getAppData(body.email)
    return {"status":True,"data":data}



