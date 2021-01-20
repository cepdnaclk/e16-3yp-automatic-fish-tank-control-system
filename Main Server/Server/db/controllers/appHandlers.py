from Server.db.controllers.handlers import retrieve_user

async def getAppData(email:str):
    user=await retrieve_user(email)
    if not user:
        raise Exception("Error in gettin user")
    return user["devices"]
    
    
    