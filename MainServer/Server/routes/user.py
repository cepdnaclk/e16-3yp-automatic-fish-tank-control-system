from fastapi import APIRouter
from Server.views.tokenControler import get_current_active_user
from fastapi import Depends
from fastapi import  Request,Header


router = APIRouter()

@router.get("/users/", tags=["users"])
async def checkToken(current_user= Depends(get_current_active_user)):
    if current_user:
        pass
    
    return current_user

# @router.get("/users/", tags=["users"])
# async def read_users():
#     return [{"username": "Foo"}, {"username": "Bar"}]


