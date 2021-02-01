import requests
import json

from user.config import PORT, IP

Url = "http://"+IP+":"+PORT+"/"


token = ""


def login(email, password):
    data = {"email": email, "password": password}
    login_url = Url+"login"
    r = requests.post(login_url, data=json.dumps(data))

    if(r.status_code == 200):
        print("Login is sucess")
        token = r.headers['Authorization']
        print(r.json)
        print(token)
        return True
    elif(r.status_code == 401):
        print("Incorrect username or password")
        return False

    else:
        print("login failed")
        return False
        



def signup(fname: str, lname: str, email: str, password: str):
    data = {
        "fname": fname,
        "lname": lname,
        "email": email,
        "password": password
    }
    signup_url = Url+"signup"

    r = requests.post(signup_url, data=json.dumps(data))
    if r.status_code == 200:
        token = r.headers['Authorization']
        print("sign up sucess")
        print(r.json)
        print(token)
        return True
    elif r.status_code == 406:
        print("you already signedup from this email")
        return False
        

    else:
        print("Status code "+str(r.status_code))
        print("sign up failed")
        return False
        
#signup("harshana","yoshith","yoshith1996@gmail.com","tharu96")


def changepassword(old_password: str, new_password: str, email: str):
    data = {
        "old_password": old_password,
        "new_password": new_password,
        "email": email
    }

    changepassword_url = Url+"changepassword"
    r = requests.post(changepassword_url, data=json.dumps(data))

    if r.status_code == 200:
        token = r.headers['Authorization']
        print("Change password sucess")
        print(r.json)
        print(token)
        return True
    elif r.status_code == 406:
        print("User not exist")
        return False
        
    elif r.status_code == 422:
        print("validation error")
        return False
    else:
        print("Status code "+str(r.status_code))
        print("Change Password faild")
        return False
  
#changepassword("tharu96", "manofthematch","hyoshith@gmail.com")


def changeNames(fname: str, lname: str, email: str, password: str):
    data = {
        "fname": fname,
        "lname": lname,
        "email": email,
        "password": password
    }

    changenames_url = Url+"changenames"
    r = requests.post(changenames_url, data=json.dumps(data))

    if r.status_code == 200:
        token = r.headers['Authorization']
        print("Change name sucess")
        print(r.json)
        print(token)
        return True
    elif r.status_code == 406:
        print("User not exist")
        return False
        
    elif r.status_code == 422:
        print("validation error")
        return False
    else:
        print("Status code "+str(r.status_code))
        print("Change name faild")
        return False

#did not complte yet
def confirmationPassword(email: str, code: str):
    data = {
        "email": email,
        "code": code
    }

    confirmationpassword_url = Url+"confirmation"
    r = requests.post(confirmationpassword_url, data=json.dumps(data))

    if r.status_code == 200:
        print("Confirmation code get sucess ")
        print(r.json)
        return True
    else:
        print("Status code "+str(r.status_code))
        print("Confirmation code get faild")
        return False


def forgetPassword(email: str):
    data = {
        "email": email
    }
    
    forgetpassword_url=Url+"forgetpassword"
    r = requests.post(forgetpassword_url, data=json.dumps(data))
    
    if r.status_code == 200:
        print("Forget password email send sucessfully")
        print(r.json)
        return True
    else:
        print("Status code "+str(r.status_code))
        print("Forget password email send faild")
        return False
        
#def feedControl(authorization : str ,deviceID : str):
    

