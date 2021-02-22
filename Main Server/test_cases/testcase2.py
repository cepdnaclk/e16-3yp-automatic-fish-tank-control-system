from  user.user import *
from  tank_api.tank_api import *
from  control.controlers import *
from  appData.appData import * 




print("\n\n==================================================================================\n==================================================================================")
print("\n\n *************login test*****************\n\n")

test = 2

testbody=[{"email":"yoshith1996@gmail.com","pw":"tharu9912"},
    {"email":"hyoshith@gmail.com","pw":"paasword123"},
    {"email":"randikavirajmax@gmail.com","pw":"paasword456"},
    {"email":"supunvindula98@gmail.com","pw":"paasword789"}]

succes_test_cases=0

for i in range(4):
    print("      test cases number "+str(i+1))
    print("      expected result = login is sucess")
    print("      result  =  ",end='')
    test_body=testbody[i]
    if (login(test_body["email"],test_body["pw"])) :
        succes_test_cases+=1
        
    print("\n")

print("\n\n      number of test cases = 4")
print("      number of succesed test cases = "+str(succes_test_cases)+"\n\n")


print("\n\n==================================================================================\n==================================================================================")


    