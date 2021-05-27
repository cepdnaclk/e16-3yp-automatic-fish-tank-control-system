from Server.db.controllers.connection import phone_collection

async def addPhoneNumber(phoneNumber,deviceId):
    try:
        phone=dict()
        phone['phoneno']=phoneNumber
        phone['device_id']=deviceId
        await phone_collection.insert_one(phone)
        return True
    except:
      print('An exception occurred in addPhoneNumber')
      return False

    
    
async def getPhoneNumber(tank_id):
    phone = await phone_collection.find_one({"device_id": tank_id})
    return phone['phoneno']