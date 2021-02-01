from  user.user import *
from  tank_api.tank_api import *
from  control.controlers import *
from  appData.appData import * 




print("\n\n==================================================================================\n==================================================================================")
print("\n\n *************signup test*****************\n\n")

test = 1

testbody=[{"fname":"mahela" ,"lname":"jayawardana","email":"yoshith1996@gmail.com","pw":"tharu9912"},
    {"fname":"yoshith" ,"lname":"harshana","email":"hyoshith@gmail.com","pw":"paasword123"},
    {"fname":"randika" ,"lname":"viraj","email":"randikavirajmax@gmail.com","pw":"paasword456"},
    {"fname":"supun" ,"lname":"vindula","email":"supunvindula98@gmail.com","pw":"paasword789"}]

succes_test_cases=0
for i in range(4):
    print("      test cases number "+str(i+1))
    print("      expected result = sign up sucess")
    print("      result  =  ",end='')
    test_body=testbody[i]
    if (signup(test_body["fname"],test_body["lname"],test_body["email"],test_body["pw"])) :
        succes_test_cases+=1
    print("\n")

print("\n\n      number of test cases = 4")
print("      number of succesed test cases = "+str(succes_test_cases)+"\n\n")


print("\n\n==================================================================================\n==================================================================================")


    