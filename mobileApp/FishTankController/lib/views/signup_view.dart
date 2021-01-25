import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../background/background.dart';
import '../blocs/signupbloc/signupbloc.dart';
import '../blocs/signupbloc/signup_events.dart';
import '../functions/alert.dart';
import '../models/signupmodel.dart';

class SignupView extends StatefulWidget {
  bool status;
  final String topic;
  final String message;
  SignupView({this.status = false, this.topic, this.message});
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  String fname = "";
  String lname = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  bool passwordCheck(String paswd, String confrmpaswd) {
    if (paswd == confrmpaswd) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final signupbloc = BlocProvider.of<SignupBloc>(context);

    Size size = MediaQuery.of(context).size;

    if (widget.status) {
      WidgetsBinding.instance.addPostFrameCallback(
          (duration) => alertMessage(context, widget.topic, widget.message));
      widget.status = false;
    }

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
              elevation: 10.0,
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.3, vertical: 10),
              color: Colors.black,
              onPressed: () {
                if (this.passwordCheck(password, confirmPassword)) {
                  signupbloc.add(CallSignupEvent(
                      SignupRequestModel(fname, lname, email, password)));
                } else {
                  alertMessage(
                      context, "Error", "Confirm Password is not matching");
                }
              },
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
