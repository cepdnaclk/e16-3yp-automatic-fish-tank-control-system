import requests
import json

from test_cases.user.config import PORT, IP

Url = "http://"+IP+":"+PORT+"/"

token = ""


def login(email, password):
    data = {"email": email, "password": password}
    login_url = Url+"login"
    r = requests.post(login_url, data=json.dumps(data))

    if(r.status == 200):
        print("Login is sucess")
        token = r.headers['Authorization']
        print(r.json)
        print(token)
    else:
        print("login failed")


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

    else:
        print("Status code "+str(r.status_code))
        print("sign up failed")


def changepassword(old_password: str, new_password: str, email: str):
    data = {
        "old_password": old_password,
        "new_password": new_password,
        "email": email
    }

    changepassword_url = Url+"changepassword"
    r = requests.post(changepassword, data=json.dumps(data))

    if r.status_code == 200:
        token = r.headers['Authorization']
        print("Change password sucess")
        print(r.json)
        print(token)
    else:
        print("Status code "+str(r.status_code))
        print("Change Password faild")


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
    else:
        print("Status code "+str(r.status_code))
        print("Change name faild")


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
    else:
        print("Status code "+str(r.status_code))
        print("Confirmation code get faild")


def forgetPassword(email: str):
    data = {
        "email": email
    }
    
    forgetpassword_url=Url+"forgetpassword"
    r = requests.post(forgetpassword_url, data=json.dumps(data))
    
    if r.status_code == 200:
        print("Forget password email send sucessfully")
        print(r.json)
    else:
        print("Status code "+str(r.status_code))
        print("Forget password email send faild")

