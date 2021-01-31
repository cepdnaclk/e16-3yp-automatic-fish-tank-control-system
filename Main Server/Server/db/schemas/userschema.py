from typing import Optional, List
from pydantic import BaseModel, EmailStr, Field


class ProfileSchema(BaseModel):
    fname: str = Field(...)
    lname: str = Field(...)


class SignUpSchema(BaseModel):
    fname: str = Field(...)
    lname: str = Field(...)
    email: EmailStr = Field(...)
    password: str = Field(...)


class Login(BaseModel):
    email: EmailStr = Field(...)
    password: str = Field(...)


class UserSchema(BaseModel):
    email: EmailStr = Field(...)
    password: str = Field(...)
    devices: List[str] = []


class ConfirmCode(BaseModel):
    email: EmailStr = Field(...)
    code: str = Field(...)


class Device(BaseModel):
    device_id: str


class DeviceNotification(BaseModel):
    id: str
    msg: str


class DeviceData(BaseModel):
    id: str
    ph: str
    tmp: str


class AddTank(BaseModel):
    email: EmailStr = Field(...)
    device_id: str
    fish_names: List[str]
    fish_count: List[int]
    height: int
    lenght: int
    width: int


class RetriveData(BaseModel):
    email: EmailStr = Field(...)
    device_id: str
    day: str


class AppData(BaseModel):
    email: EmailStr = Field(...)


class ChangePassword(BaseModel):
    old_password: str
    new_password: str
    email: EmailStr = Field(...)
    
class DeleteTank(BaseModel):
    email: EmailStr = Field(...)
    device_id: str
    
