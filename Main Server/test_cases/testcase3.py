from  user.user import *
from  tank_api.tank_api import *
from  control.controlers import *
from  appData.appData import * 




print("\n\n==================================================================================\n==================================================================================")
print("\n\n *************change password*****************\n\n")

test = 3

testbody=[{"oldpw":"tharu9912","newpw":"pasword101112","email":"yoshith1996@gmail.com"},
    {"oldpw":"paasword123","newpw":"pasword131415","email":"hyoshith@gmail.com"},
    {"oldpw":"paasword456","newpw":"pasword161718","email":"randikavirajmax@gmail.com"},
    {"oldpw":"paasword789","newpw":"pasword192021","email":"supunvindula98@gmail.com"}]

succes_test_cases=0
for i in range(4):
    print("      test cases number "+str(i+1))
    print("      expected result = Change password sucess")
    print("      result  =  ",end='')
    test_body=testbody[i]
    if (changepassword(test_body["oldpw"],test_body["newpw"],test_body["email"])) :
        succes_test_cases+=1
    print("\n")

print("\n\n      number of test cases = 4")
print("      number of succesed test cases = "+str(succes_test_cases)+"\n\n")


print("\n\n==================================================================================\n==================================================================================")


    