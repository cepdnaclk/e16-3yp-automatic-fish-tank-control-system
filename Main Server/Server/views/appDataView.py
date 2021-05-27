from fastapi import Body, Header, HTTPException, status, Response
from typing import Optional



from Server import app
from Server.db.schemas.userschema import AddTank, RetriveData, AppData, Device, DeleteTank
from Server.db.controllers.tankHandlers import addNewTank, getFishNamesFromDB,removeTank
from Server.db.controllers.influxHandlers import retriveData
from Server.db.controllers.appHandlers import getAppData
from Server.views.userView import setToken
from Server.controllers.tokenControllers import token_check
from Server.db.controllers.phoneHandlers import addPhoneNumber


@app.post("/app/addtank")
async def addTank(response: Response, Authorization: Optional[str] = Header(None), body: AddTank = Body(...)):
    user = await token_check(Authorization)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Authorization Error",
            headers={"WWW-Authenticate": "Bearer"},
        )
    tank = dict()
    tank["device_id"] = body.device_id
    tank["fish_names"] = body.fish_names
    tank["fish_count"] = body.fish_count
    tank["height"] = body.height
    tank["lenght"] = body.lenght
    tank["width"] = body.width

    if (await addNewTank(tank, body.email) and await addPhoneNumber(body.phone_no,body.device_id)):
        access_token = setToken(body.email)
        response.headers["Authorization"] = "Bearer "+access_token
        return{"status": True}
    raise HTTPException(
        status_code=status.HTTP_406_NOT_ACCEPTABLE,
        detail="Incorrect Tank Id",
        headers={"WWW-Authenticate": "Bearer"},
    )


@app.post("/app/retrivedata")
async def retriveTankData(response: Response, Authorization: Optional[str] = Header(None), body: RetriveData = Body(...)):
    user = await token_check(Authorization)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Authorization Error",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token = setToken(body.email)
    response.headers["Authorization"] = "Bearer "+access_token
    data = await retriveData(body.device_id, body.day)
    
    for i in range(len(data)):
        d=data[i][0].split("T")
        data[i][0]=d[0]+" "+d[1].split(".")[0]
    return {"data": data}


@app.post("/app/getdevicedata")
async def retriveDevicesData(response: Response, Authorization: Optional[str] = Header(None), body: AppData = Body(...)):
    user = await token_check(Authorization)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Authorization Error",
            headers={"WWW-Authenticate": "Bearer"},
        )
    try:
        data = await getAppData(body.email)
    except:
        raise HTTPException(
            status_code=status.HTTP_406_NOT_ACCEPTABLE,
            detail="Wrong email",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token = setToken(body.email)
    response.headers["Authorization"] = "Bearer "+access_token
    return {"data": data}


@app.post("/app/fishnames")
async def getFishNames(response: Response, Authorization: Optional[str] = Header(None), body: Device = Body(...)):
    user = await token_check(Authorization)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Authorization Error",
            headers={"WWW-Authenticate": "Bearer"},
        )
    else:
        try:
            data = await getFishNamesFromDB(body.device_id)
            return data
        except:
            raise HTTPException(
                status_code=status.HTTP_406_NOT_ACCEPTABLE,
                detail="Incorrect Tank Id",
                headers={"WWW-Authenticate": "Bearer"},
            )


@app.post("/app/deletetank")
async def deleteTank(response: Response, Authorization: Optional[str] = Header(None), body: DeleteTank = Body(...)):
    user = await token_check(Authorization)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Authorization Error",
            headers={"WWW-Authenticate": "Bearer"},
        )
    else:
        try:
            await removeTank(body.email,body.device_id)
            access_token = setToken(body.email)
            response.headers["Authorization"] = "Bearer "+access_token
            return {"status":True}
        except:
            raise HTTPException(
                status_code=status.HTTP_406_NOT_ACCEPTABLE,
                detail="Incorrect Tank Id",
                headers={"WWW-Authenticate": "Bearer"},
            )
