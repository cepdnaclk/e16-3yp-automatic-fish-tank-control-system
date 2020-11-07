from fastapi import FastAPI
from fastapi import APIRouter, Body
from fastapi.encoders import jsonable_encoder
from Server.routes import user


app=FastAPI()

app.include_router(user.router)


from Server.views import main