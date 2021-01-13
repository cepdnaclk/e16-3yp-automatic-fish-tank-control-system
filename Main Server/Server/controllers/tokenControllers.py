from jose import JWTError,jwt,ExpiredSignatureError
from datetime import datetime, timedelta

from Server.controllers.config import ACCESS_TOKEN_EXPIRE_MINUTES,ALGORITHM,SECRET_KEY
from Server.db.controllers.handlers import retrieve_user



async def get_current_active_user(email:str,exp:int):
    
    user= await retrieve_user(email)
    return user
    


async def token_check(header:str):
    try:
        token=header.split(" ")[1].strip()
        payload =jwt.decode(token,SECRET_KEY, algorithms=['HS256'])
        email: str = payload.get("sub")
        exp=payload.get("exp")
        if email is None:
            raise Exception("Error in token")
        user = await get_current_active_user(email,exp)
        return user
    except JWTError:
        print(JWTError)
        return {}
        
    except:
        print("Error in token controller")
        return {}
    
