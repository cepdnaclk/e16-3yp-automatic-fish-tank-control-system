import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../functions/alert.dart';
import '../background/background.dart';
import '../blocs/loginbloc/loginbloc.dart';
import '../blocs/loginbloc/loginevents.dart';
import '../models/loginmodel.dart';

class LoginView extends StatefulWidget {
  final String topic;
  final String message;
  bool alertstatus;

  LoginView({this.topic, this.message, @required this.alertstatus});
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String useraname = "";
  String password = "";
  bool obsecureText=true;

  _launchURL(BuildContext context) async {
    const url = 'https://youtube.com';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      alertMessage(context, "Error", "Something wrong with open browser");
      // throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginbloc = BlocProvider.of<LoginBloc>(context);

    Size size = MediaQuery.of(context).size;

    if (widget.alertstatus) {
      WidgetsBinding.instance.addPostFrameCallback(
          (duration) => alertMessage(context, widget.topic, widget.message));
      widget.alertstatus = false;
    }

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.07),
              Container(
                width: size.width * 0.8,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: TextField(
                  onChanged: (value) {
                    useraname = value;
                  },
                  decoration: InputDecoration(
                      hintText: "User name",
                      icon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
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
                  obscureText: this.obsecureText,
                  decoration: InputDecoration(
                      hintText: "Password",
                      icon: Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: ()=>this.obsecureText=!this.obsecureText,
                        child: Icon(Icons.visibility),),
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
                onPressed: () => loginbloc.add(CallLoginEvent(
                    LoginRequestModel(email: useraname, passord: password))),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Forget Password ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await this._launchURL(context);
                    },
                    child: Text(
                      "Click Here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
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
        ),
      ),
    );
  }
}
