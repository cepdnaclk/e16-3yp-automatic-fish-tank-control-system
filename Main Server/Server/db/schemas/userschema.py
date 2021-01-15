from typing import Optional,List
from pydantic import BaseModel, EmailStr, Field

class ProfileSchema(BaseModel):
    fname: str = Field(...)
    lname: str = Field(...)


    
class SignUpSchema(BaseModel):
    fname: str = Field(...)
    lname: str = Field(...)
    email: EmailStr = Field(...)
    password: str=Field(...)
    
    
class UserSchema(BaseModel):
    email: EmailStr = Field(...)
    password: str=Field(...)
    devices:List[str] = []
    
class ConfirmCode(BaseModel):
    email: EmailStr = Field(...)
    code:str=Field(...)
    
    
class Device(BaseModel):
    device_id:str
    
class DeviceNotification(BaseModel):
    device_id:str
    msg:str