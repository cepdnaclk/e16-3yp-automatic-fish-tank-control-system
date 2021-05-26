#include <Arduino.h>
#include <OneWire.h> 
#include <DallasTemperature.h>
#include <WiFi.h>
#include <HTTPClient.h>
#include <Arduino_JSON.h>
#include <FS.h>
#include <PubSubClient.h>


#define ALERT_PORT 18
#define FEED_PORT  21
#define WATER_REMOVE_PORT  22
#define WATER_FILL_PORT 22
#define WATER_RENEW_DELAY 1000

// GPIO where the DS18B20 is connected to
const int oneWireBus = 4;  
// GPIO where ph module connects
int pHSense = 19;

// set wifi credentials
const char* ssid = "SLT-4G-6161";
const char* password = "07DR71T1NT9";

// Id of the device
String device_ID = "2";

// feeding time on tank
int feedtime = 5000;

// Server name 
String serverName = "http://35.175.152.136:33000/tankapi/";


// Setup a oneWire instance to communicate with any OneWire devices
OneWire oneWire(oneWireBus);

// Pass our oneWire reference to Dallas Temperature sensor 
DallasTemperature sensors(&oneWire);
// temparature stable range
float stable_temp=28;

// ph stable range
int stable_ph=7;

// clients for mqtt connection
WiFiClient espClient;
PubSubClient client(espClient);




void reconnect() {
  /*
    Reconnect the mqtt client
    Loop until we're reconnected

  */
    while (!client.connected()) {
      Serial.print("Attempting MQTT connection...");
      // Attempt to connect
      if (client.connect("ESP32 Client")) {
        Serial.println("connected");
        // ... and subscribe to topic
        client.subscribe("tank/001");
      } else {
        Serial.print("failed, rc=");
        Serial.print(client.state());
        Serial.println(" try again in 5 seconds");
        // Wait 5 seconds before retrying
        delay(5000);
      }
    }
}


String httpPOSTRequest(String serverPath,String jsonBody){
  /*
   Handle POST request and return the payload
  */
  String payload = "{}";
  // Create http object
  HTTPClient http;
  // Domain name with IP address with path
  http.begin(serverPath);
  // set json headers
  http.addHeader("Content-Type", "application/json");
  // Send HTTP POST request
  int httpResponseCode = http.POST(jsonBody);

  if (httpResponseCode > 0) {
    Serial.print("HTTP Response code: ");
    Serial.println(httpResponseCode);
    String payload = http.getString();
    Serial.println(payload);
  }else {
    Serial.print("Error code: ");
    Serial.println(httpResponseCode);
  }
  // Free resources
  http.end();

  return payload;
}




void initFeedTime(){
/* 

  Get the initial feed time from server

*/
  String serverPath = serverName + "feedtime";
    Serial.println("Init feed time body:");
  Serial.println("{\"device_id\":\""+device_ID+"\"}");
  String body=httpPOSTRequest(serverPath,"{\"device_id\":\""+device_ID+"\"}");
  JSONVar myObject = JSON.parse(body);
  feedtime = (int)myObject["s"];
}



void initTemp(){
  /* 

  Get the initial stable temparature from server

*/

  String serverPath = serverName + "temp";
  String body=httpPOSTRequest(serverPath,"{\"device_id\":\""+device_ID+"\"}");
  JSONVar myObject = JSON.parse(body);
  stable_temp= (double)myObject["s"];

}

void sendError(String msg){
  String serverPath = serverName + "error";
  httpPOSTRequest(serverPath,"{\"id\":\""+device_ID+"\",\"msg\":\""+msg+"\"}");
}

// return current temparature
float getTemparatue(){
  delay(100);
  sensors.requestTemperatures(); 
  float temperatureC = sensors.getTempCByIndex(0);
  float temperatureF = sensors.getTempFByIndex(0);
  Serial.print(temperatureC);
  Serial.println("ºC");
  Serial.print(temperatureF);
  Serial.println("ºF");
  return temperatureC;
}


// get current ph value
float getPH(){
  delay(100);
  int measuringVal = analogRead(pHSense);
  Serial.print("Measuring Raw Value > ");
  Serial.print(measuringVal);
 
  double vltValue = (3.3/4095.0) * measuringVal;
  Serial.print("Voltage Value > ");
  Serial.print(vltValue, 3);
 
  float P0 = 7 + ((1.65 - vltValue) / 0.18);
  Serial.print("\n");
  Serial.print("pH Value > ");
  Serial.print(P0, 3);
  Serial.print("\n");
  return P0;
}




void alertOn(){
  // alert signal on
  digitalWrite(ALERT_PORT,HIGH);
}

void alertOff(){
  // alert signal off
  digitalWrite(ALERT_PORT,LOW);
}




void renewWater(){
  // switch water solinid walve to fill the water and remove water from other valve
  digitalWrite(WATER_REMOVE_PORT,HIGH);
  digitalWrite(WATER_FILL_PORT,HIGH);
  delay(WATER_RENEW_DELAY);
  digitalWrite(WATER_REMOVE_PORT,LOW);
  digitalWrite(WATER_FILL_PORT,LOW);
}

void feedFish(){
  // feed the fishes
  digitalWrite(FEED_PORT,HIGH);
  delay(feedtime); 
  digitalWrite(FEED_PORT,LOW);
}

unsigned char sendData(float ph,float tmp){
  /*
    send data to the server
  */
  String serverPath = serverName + "data";
  Serial.println("send data body:");
  Serial.println("{\"id\":\" "+device_ID+"\",\"ph\":\""+String(ph)+"\",\"tmp\":\""+String(tmp)+"\"}");
  String body=httpPOSTRequest(serverPath,"{\"id\":\" "+device_ID+"\",\"ph\":\""+String(ph)+"\",\"tmp\":\""+String(tmp)+"\"}");  JSONVar myObject = JSON.parse(body);
  int no= (int)myObject["s"];
  if( no>0){
    return '1';
  }else{
    return '0';
  }
}


unsigned char checkTemprature(float temp){
  /*

   check the temparature
  
  */
  if( (temp>stable_temp-5) && (temp<stable_temp+5)){
    return '1';
  }else{
    sendError("1");
    return '0';
  }
}


unsigned char checkPh(float ph){
  /*
    check the ph value
  */
  if((ph>stable_ph-2) && (ph<stable_ph+2)){
   return '1'; 
  }else{
    sendError("2");
    return '0';
  }
}

void callback(char* topic, byte* payload, unsigned int length) {
  /*
    callback function for the mqtt client
  */
    Serial.print("Message arrived [");
    Serial.print(topic);
    Serial.print("] ");
    String data= String(*payload);
    if (data=="feed")
    {
      feedFish();
    }else{
      renewWater();
    }
    
    Serial.println(data);
}


void setup() {
// Start the Serial Monitor
  Serial.begin(115200);
  // Start the DS18B20 sensor
  sensors.begin();
  // mqtt client is now configured for use
  client.setServer(IPAddress(35,175,152,136), 1883);
  client.setCallback(callback);
  
  WiFi.begin(ssid, password);
  Serial.println("Connecting");
  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  initFeedTime();
  initTemp();
  pinMode(WATER_REMOVE_PORT,OUTPUT);
  pinMode(ALERT_PORT,OUTPUT);
  pinMode(FEED_PORT,OUTPUT);
  pinMode(WATER_FILL_PORT,OUTPUT);
}



void loop() {
  if (!client.connected()) {
  reconnect();
 }
 client.loop();

 float ph=getPH();
 float temp=getTemparatue();

 if (checkPh(ph)=='0' )
 {
   alertOn();
   renewWater();
   alertOff();
   delay(10000);
 }
 if (checkTemprature(temp)=='0')
 {
   alertOn();
   renewWater();
   alertOff();
   delay(10000);
 }
 
 if (sendData(ph,temp)=='0')
 {
   /* code */
 }
 
}