from  user.user import *
from  tank_api.tank_api import *
from  control.controlers import *
from  appData.appData import * 


#aaaaaaaaaaaaaaaaaaaaa

print("\n\n==================================================================================\n==================================================================================")
print("\n\n *************retrive TankData*****************\n\n")

test = 6
test_email[]
test_email=["yoshith1996@gmail.com","hyoshith@gmail.com","randikavirajmax@gmail.com","supunvindula98@gmail.com"]
test_DI=["1","2","3","4"]

test_hlw=[{"height":12,"length":20,"width":21},
    {"height":13,"length":20,"width":22}
    {"height":14,"length":20,"width":23}
    {"height":15,"length":20,"width":24}]
    
fish_names=[["A","B"],["C","D"],["E","F"],["G","H"]]
fish_count=[[2,3],[4,5],[6,7],[8,9]]
test_day=["2021.02.02","22021.01.16","2021.09.04","2021.03.02"]

testbody=[{"newpw":"pasword101112","email":"yoshith1996@gmail.com"},
    {"newpw":"pasword131415","email":"hyoshith@gmail.com"},
    {"newpw":"pasword161718","email":"randikavirajmax@gmail.com"},
    {"newpw":"pasword192021","email":"supunvindula98@gmail.com"}]

succes_test_cases=0
for i in range(4):
    print("      test cases number "+str(i+1))
    print("      expected result = retriveTankData sucess")
    
    test_body2=testbody[i]
    login(test_body2["email"],test_body2["newpw"])
    print("      result  =  ",end='')
    if (retriveTankData(test_email[i],test_DI[i],test_day[i],token)) :
        succes_test_cases+=1
    print("\n")

print("\n\n      number of test cases = 4")
print("      number of succesed test cases = "+str(succes_test_cases)+"\n\n")


print("\n\n==================================================================================\n==================================================================================")


    