from influxdb import InfluxDBClient

from json import loads,dumps
client = InfluxDBClient(host='localhost', port=8086)

client.switch_database('fishtank')


# data=client.query("select * from temperature where ((now()-0d > time) & (now()-1d < time)) & (id =10)")
# print()
# id="505"
# id='"'+id+'"'
# day="1d"
# ph="15"
# tmp="20"
# query_ph='INSERT 1011,ph=10 tmp=20;'
# client.write("1011,ph=10 tmp=20")
# client.query(query_ph)
# result=loads(dumps(data.raw))
# print(result["series"][0]["values"][0][1])

# json_body = [
#         {
#             "measurement": "",
#             "fields": {
#                 "ph": "",
#                 "tmp":""   
#             }
#         }
#     ]
# json_body[0]["measurement"]=id
# json_body[0]["fields"]["ph"]=ph
# json_body[0]["fields"]["tmp"]=tmp
# client.write_points(json_body)


# query = 'select * from '+id+' where ((time > now()-'+day+') and (time < now()+1d-'+day+'))'
# bind_params = {}
# bind_params['id']=id
# bind_params['day']=day

# result=client.query(query)
# data=result.raw
# print(data['series'][0]['values'])