import motor.motor_asyncio
from bson.objectid import ObjectId


MONGO_DETAILS = "mongodb://localhost:27017"

client = motor.motor_asyncio.AsyncIOMotorClient(MONGO_DETAILS)

# referenced a database  tankusers
database = client.tankusers

profiles_collection = database.get_collection("profiles_collection")

users_collection = database.get_collection("users_collection")

tank_collection = database.get_collection("tank_collection")

fish_collection =database.get_collection("fish_collection")

phone_collection=database.get_collection("phone")