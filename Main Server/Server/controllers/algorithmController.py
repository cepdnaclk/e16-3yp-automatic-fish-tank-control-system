from Server.db.controllers.connection import fish_collection, tank_collection


async def findFishTankTemperature(device_id: str):
    tank = await tank_collection.find_one({"device_id": device_id})
    if not tank:
        return 0
    avg_tmp = 0
    count = 0
    for fish in tank['fish_names']:
        fish_detail = await fish_collection.find_one({'fish_name': fish})
        if not fish_detail:
            continue
        avg_tmp = avg_tmp+fish_detail["tmp"]
        print(str(fish_detail["tmp"]))
        count = count+1
    if count == 0:
        return avg_tmp
    avg_tmp = avg_tmp/count
    return avg_tmp


async def findFeedingAmount(device_id: str):
    tank = await tank_collection.find_one({"device_id": device_id})
    if not tank:
        return 0
    avg_feed = 0
    for fish in tank['fish_names']:
        fish_detail = await fish_collection.find_one({'fish_name': fish})
        if not fish_detail:
            continue
        avg_tmp = avg_tmp+fish_detail["feed_amount"]
        print(str(fish_detail["feed_amount"]))
    return avg_feed
