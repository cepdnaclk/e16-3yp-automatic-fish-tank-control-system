from Server.db.controllers.connection import tank_collection,users_collection


async def addNewTank(tank:dict,email:str):
    try:
        tank=await tank_collection.insert_one(tank)
        user = await users_collection.find_one({"email": email})
        if user:
            user["devices"].append(tank["device_id"])
            updated_user = await profiles_collection.update_one(
                {"email": email}, {"$set": user}
            )
        return True
    except:
        print("Error in addNewTank")
        return False
    
    
        
    