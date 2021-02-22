from  user.user import *
from  tank_api.tank_api import *
from  control.controlers import *
from  appData.appData import * 


#aaaaaaaaaaaaaaaaaaaaa

print("\n\n==================================================================================\n==================================================================================")
print("\n\n *************add tank*****************\n\n")

test = 5
test_DI=["1","2","3","4"]

test_hlw=[{"height":12,"length":20,"width":21},
    {"height":13,"length":20,"width":22},
    {"height":14,"length":20,"width":23},
    {"height":15,"length":20,"width":24}]
    
fish_names=[["A"],["C"],["E"],["G"]]
fish_count=[[2],[4],[6],[8]]

testbody=[{"newpw":"pasword101112","email":"yoshith1996@gmail.com"},
    {"newpw":"pasword131415","email":"hyoshith@gmail.com"},
    {"newpw":"pasword161718","email":"randikavirajmax@gmail.com"},
    {"newpw":"pasword192021","email":"supunvindula98@gmail.com"}]

succes_test_cases=0

for i in range(4):
    print("      test cases number "+str(i+1))
    print("      expected result = add tank sucess")
    
    test_body=test_hlw[i]
    test_body2=testbody[i]
    login(test_body2["email"],test_body2["newpw"])
    print("      result  =  ",end='')
    if (addTank(test_DI[i],fish_names[i],fish_count[i],test_body["height"],test_body["length"],test_body["width"],token)) :
        succes_test_cases+=1
    print("\n")

print("\n\n      number of test cases = 4")
print("      number of succesed test cases = "+str(succes_test_cases)+"\n\n")


print("\n\n==================================================================================\n==================================================================================")


    