import 'package:flutter/material.dart';

import '../background/background.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String fname;
    String lname;
    String email;
    String password;
    String confirmPassword;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.4,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: TextField(
                    onChanged: (value) {
                      fname = value;
                    },
                    decoration: InputDecoration(
                        hintText: "Frist Name",
                        icon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(width: size.width * 0.02),
                Container(
                  width: size.width * 0.4,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: TextField(
                    onChanged: (value) {
                      lname = value;
                    },
                    decoration: InputDecoration(
                        hintText: "Last Name", border: InputBorder.none),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              width: size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: TextField(
                onChanged: (value) {
                  lname = value;
                },
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    hintText: "Email",
                    border: InputBorder.none),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              width: size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: TextField(
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    icon: Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                    suffixIcon: Icon(Icons.visibility),
                    border: InputBorder.none),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              width: size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: TextField(
                onChanged: (value) {
                  confirmPassword = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Confirm Password",
                    icon: Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                    suffixIcon: Icon(Icons.visibility),
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.3, vertical: 10),
              color: Colors.black,
              onPressed: () {},
              child: Text(
                "SIGNUP",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.1, vertical: 10),
              color: Colors.grey,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "BACK",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
