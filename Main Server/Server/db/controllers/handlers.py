from Server.db.controllers.connection import users_collection
from Server.db.controllers.connection import profiles_collection

def profile_helper(profile) -> dict:
    return {
        "fname": profile["fname"],
        "lname": profile["lname"],
        "email": student["email"]
    }
    
def user_helper(user) -> dict:
    return {
        "email": user["email"],
        "password": user["password"],
        "devices": user["devices"]
    }
    
    
# Retrieve user present in the database
async def retrieve_user(email: str) -> dict:
    user = await users_collection.find_one({"email": email})
    if user:
        return user_helper(user)
    return {}

# Add a new user into to the database
async def add_user(user: dict,prof: dict) -> dict:
    new_user = await users_collection.insert_one(user)
    if new_user:
        new_prof = await profiles_collection.insert_one(prof)
        if new_prof:
            return True
    return False



# Update a user passweord
async def update_user_password(email: str, password:str):
    # Return false if an empty request body is sent.
    if len(data) < 1:
        return False
    user = await users_collection.find_one({"email": email})
    if user:
        user["password"]=password
        updated_user = await users_collection.update_one(
            {"email": ObjectId(email)}, {"$set": user}
        )
        if updated_user:
            return True
    return False

# Update a user names
async def update_user_name(email: str, fname:str,lname:str):
    # Return false if an empty request body is sent.
    if len(data) < 1:
        return False
    user = await profiles_collection.find_one({"email": email})
    if user:
        user["fname"]=fname
        user["lname"]=lname
        updated_user = await profiles_collection.update_one(
            {"email": ObjectId(email)}, {"$set": user}
        )
        if updated_user:
            return True
    return False