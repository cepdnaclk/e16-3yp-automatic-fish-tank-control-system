from Server.db.controllers.influxdbConnection import client
from Server.db.controllers.connection import tank_collection

async def storeData(id:str,ph:str,tmp:str):
    
    tank= await tank_collection.find_one({"device_id": id})
    if tank:
        try:
            json_body = [
                    {
                        "measurement": "",
                        "fields": {
                            "ph": "",
                            "tmp":""   
                        }
                    }
                ]
            json_body[0]["measurement"]=id
            json_body[0]["fields"]["ph"]=ph
            json_body[0]["fields"]["tmp"]=tmp
            client.write_points(json_body)
            return True
        except :
            print("Error in storeData process")
            return False
    return False

# id="505"
#day="1d"


async def retriveData(id:str,day:str):
    try:
        id='"'+id+'"'
        query = 'select * from '+id+' where ((time > now()-'+day+'))'
        result=client.query(query)
        data=result.raw
        print(data['series'][0]['values'])
        return data['series'][0]['values']
    except:
        print("Error in retrive data from influx")
        return []
    
    

