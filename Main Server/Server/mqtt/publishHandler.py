import paho.mqtt.client as mqtt

from Server.mqtt.config import BROKER,BROKER_PORT


def on_connect(client, userdata, flags, rc):
    if rc==0:
        print("connected OK")
    else:
        client.bad_connection_flag=True 
        print("Bad connection Returned code=",rc)
        
def on_publish(mqttc, obj, mid):
    print("mid: " + str(mid))

def publishMessage(topic:str,msg:str,qulity:int):

    mqtt.Client.bad_connection_flag=False 
    client=mqtt.Client("server",False)
    client.on_connect=on_connect
    client.on_publish = on_publish
    
    try:
        client.username_pw_set("serverfish","--")
        client.connect(BROKER,BROKER_PORT,60)
    except:
        print("connection failed mqtt publishing message")
        raise Exception("Error Happen") 
        return
    
    if client.bad_connection_flag:
        raise Exception("Error Happen") 
        return
    
    client.loop_start()
    infot = client.publish(topic,payload=msg,qos=qulity) 
    infot.wait_for_publish()   
    client.loop_stop()    #Stop loop 
    client.disconnect() # disconnect
    