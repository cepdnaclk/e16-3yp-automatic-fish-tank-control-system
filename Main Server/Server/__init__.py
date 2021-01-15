from fastapi import FastAPI

app=FastAPI()

from .views import userView,tankControlViews
from .controllers import tokenControllers