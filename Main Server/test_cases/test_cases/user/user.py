import requests

from test_cases.user.config import PORT, IP

Url = "http://"+IP+":"+PORT+"/"

token = ""


def login(email, password):
    data = {"email": email, "password": password}
    login_url = Url+"login"
    r = requests.post(login_url, data=data)

    if(r.status == 200):
        print("Login is sucess")
        token = r.headers['Authorization']
        print(r.json)
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

    r = requests.post(signup_url, data=data)
    if r.status_code == 200:
        token = r.headers['Authorization']
        print("sign up sucess")
        print(r.json)

    else:
        print("Status code "+str(r.status_code))
        print("sign up failed")


def changepassword(old_password: str, new_password: str, email: str):
    data = {
        "old_password": old_password,
        "new_password": new_password,
        "email": email
    }
    
    changepassword_url=Url+"changepassword"
    r = requests.post(changepassword,data=data)
    
    if r.status_code==200:
        token = r.headers['Authorization']
        print("Change password sucess")
        print(r.json)
    else:
        print("Status code "+str(r.status_code))
        print("Change Password faild")
        
