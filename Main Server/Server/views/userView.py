from datetime import datetime, timedelta
from fastapi import Depends, FastAPI, HTTPException, status,Body,Response
from jose import JWTError, jwt
from passlib.context import CryptContext
from typing import Optional



from Server import app
from Server.db.controllers.handlers import retrieve_user,add_user,update_user_name
from Server.db.schemas.userschema import SignUpSchema,ProfileSchema,UserSchema,ConfirmCode
from Server.controllers.config import ACCESS_TOKEN_EXPIRE_MINUTES,ALGORITHM,SECRET_KEY
from Server.email.handlers import sendEmail




pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")



def verify_password(plain_password, hashed_password):
    try:
        return pwd_context.verify(plain_password, hashed_password)
    except :
        return True
    


def get_password_hash(password):
    return pwd_context.hash(password)



def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    to_encode = data.copy()
    # should fixed here
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

def setToken(email:str):
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(data={"sub": email},expires_delta=access_token_expires)
    return access_token

@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.post("/login")
async def login(response: Response,form_data: UserSchema = Body(...)):

    user = await retrieve_user(form_data.email)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    else:
        print(form_data.password)
        if  verify_password(form_data.password, user['password']):
            access_token=setToken(user["email"])
            response.headers["Authorization"]="Bearer "+access_token
            return {"status":True}
        else:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Incorrect username or password",
                headers={"WWW-Authenticate": "Bearer"},
                )
        
        
        


@app.post("/signup")
async def signup(response: Response,signupuser: SignUpSchema = Body(...)):
    profile=dict()
    user=dict()
    
    extince=await retrieve_user(sigbupuser.email)
    if extince:
        return {}
    
    profile["fname"]=signupuser.fname
    profile["lname"]=signupuser.lname
    profile["email"]=signupuser.email
    
    user["email"]=signupuser.email
    user["password"]=get_password_hash(signupuser.password)
    user["devices"]=[]
    
    new_profile  = await add_user(user,profile)
    
    if new_profile:
            access_token=setToken(signupuser.email)
            response.headers["Authorization"]="Bearer "+access_token
            return {"status":True}
    return {"status":False}
   
    
    
@app.post("/changepassword")
async def changePassword(response: Response,form_data: UserSchema = Body(...)):
    
    user = await retrieve_user(form_data.email)
    if user:
        if verify_password(form_data.password, user['password']):
            prof=await update_user_name(form_data.email,form_data.fname,form_data.lname)
            if prof:
                access_token=setToken(form_data.email)
                response.headers["Authorization"]="Bearer "+access_token
                return {"status":True}
    return {"status":False}    
    
    
@app.post("/confirmation")
async def confirm(response:Response,body:ConfirmCode=Body(...)):
    sendEmail(body.email,body.code)
    return {"status":True}
    