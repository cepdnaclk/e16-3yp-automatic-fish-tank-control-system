from fastapi import FastAPI


app=FastAPI()



from .views import userView,tankControlViews,tankapiView,appDataView
from .controllers import tokenControllers