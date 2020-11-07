from fastapi import  Request,Header
from fastapi.security import OAuth2PasswordBearer
from jose import JWTError,jwt
from fastapi import Depends, FastAPI, HTTPException, status
from Server.views.config import ACCESS_TOKEN_EXPIRE_MINUTES,ALGORITHM,SECRET_KEY
from Server.db.database import retrieve_user
from Server.db.schemas import UserSchema

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")

async def get_current_user(Authorization: str = Header(None)):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    token=Authorization.split(" ")[1].strip()
    print(token)
    payload = await jwt.decode(token,SECRET_KEY, algorithms=["HS256"])
    try:
        payload = await jwt.decode(token,SECRET_KEY, algorithms=["HS256"])
        email: str = payload.get("sub")
        print(email)
        if email is None:
            raise credentials_exception
        # token_data = TokenData(username=username)
    except JWTError:
        print(JWTError)
        raise credentials_exception
    # user = get_user(fake_users_db, username=token_data.username)
    # if user is None:
    #     raise credentials_exception
    return email



async def get_current_active_user(current_user= Depends(get_current_user)):
    # if current_user.disabled:
    #     raise HTTPException(status_code=400, detail="Inactive user")
    return current_user




