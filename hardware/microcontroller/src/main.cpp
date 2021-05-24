#include <Arduino.h>
#include <OneWire.h> 
#include <DallasTemperature.h>
#include <WiFi.h>
#include <HTTPClient.h>
#include <FS.h>

#define ALERT_PORT 14
#define FEED_PORT  23
#define WATER_REMOVE_PORT  22
#define WATER_FILL_PORT 22
#define TEMPO_PIN  17 //pH meter Analog output to ESP Analog Input 14
#define WATER_RENEW_DELAY 60000

// GPIO where the DS18B20 is connected to
const int oneWireBus = 4;  
// GPIO where ph module connects
int pHSense = 19;

// set wifi credentials
const char* ssid = "REPLACE_WITH_YOUR_SSID";
const char* password = "REPLACE_WITH_YOUR_PASSWORD";

// Server name 
String serverName = "http://192.168.1.106:3000/";


// Setup a oneWire instance to communicate with any OneWire devices
OneWire oneWire(oneWireBus);

// Pass our oneWire reference to Dallas Temperature sensor 
DallasTemperature sensors(&oneWire);
// temparature stable range
float stable_temp=120.0;

// ph stable range
int stable_ph=140;

int feed_time=1000;

unsigned char checkTemarature(){
  // check the temparature
  // call sensors.requestTemperatures() to issue a global temperature 
 // request to all devices on the bus 
  sensors.requestTemperatures(); // Send the command to get temperature readings 
  if( stable_temp-10<sensors.getTempCByIndex(0)<stable_temp+10){
  return '1';

  }else{
    return '0';
  }
}

unsigned char checkPh(){
  //check the ph value
  if(stable_ph-5<analogRead(pHSense)<stable_ph+5){
   return '1'; 
  }else{
    return '0';
  }
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
  delay(feed_time); 
  digitalWrite(FEED_PORT,LOW);
}

void setup() {

    // Start the Serial Monitor
  Serial.begin(115200);
  // Start the DS18B20 sensor
  sensors.begin();

  WiFi.begin(ssid, password);
  Serial.println("Connecting");
  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    // Serial.print(".");
  }
  pinMode(WATER_REMOVE_PORT,OUTPUT);
  pinMode(ALERT_PORT,OUTPUT);
  pinMode(FEED_PORT,OUTPUT);
  pinMode(WATER_FILL_PORT,OUTPUT);
  // Start up the library 
  sensors.begin(); 
}

void sendData(){
  // send data to the server
  String serverPath = serverName + "?temperature=24.37";

// Your Domain name with URL path or IP address with path
  // http.begin(serverPath.c_str());

// Send HTTP GET request
//  int httpResponseCode = http.GET();
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

void getStableTemparature(){

}

void getFeedTime(){

}

void loop() {
  
}