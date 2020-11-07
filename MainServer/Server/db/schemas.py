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
    
    


    