from  user.user import *
from  tank_api.tank_api import *
from  control.controlers import *
from  appData.appData import * 


#aaaaaaaaaaaaaaaaaaaaa

print("\n\n==================================================================================\n==================================================================================")
print("\n\n *************renew*****************\n\n")

test = 7

test_DI=["1","2","3","4"]


 testbody=[{"newpw":"pasword101112","email":"yoshith1996@gmail.com"},
    {"newpw":"pasword131415","email":"hyoshith@gmail.com"},
    {"newpw":"pasword161718","email":"randikavirajmax@gmail.com"},
    {"newpw":"pasword192021","email":"supunvindula98@gmail.com"}]   


succes_test_cases=0
for i in range(4):
    print("      test cases number "+str(i+1))
    print("      expected result = feed control  signaling sucess")
    
    test_body2=testbody[i]
    login(test_body2["email"],test_body2["newpw"])
    print("      result  =  ",end='')
    if (renew(test_DI[i],token)) :
        succes_test_cases+=1
    print("\n")

print("\n\n      number of test cases = 4")
print("      number of succesed test cases = "+str(succes_test_cases)+"\n\n")


print("\n\n==================================================================================\n==================================================================================")


    