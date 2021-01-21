from Server.db.controllers.handlers import retrieve_user

async def getAppData(email:str):
    user=await retrieve_user(email)
    print(user)
    if not user:
        raise Exception("Error in getting user")
    return user["devices"]
    
    
    