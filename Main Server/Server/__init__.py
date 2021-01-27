from fastapi import FastAPI
import aioredis


app=FastAPI()



from .views import userView,tankControlViews,tankapiView,appDataView
from .controllers import tokenControllers