import 'package:flutter/material.dart';

import './background.dart';
import './login.dart';
import './signup.dart';
import './starting_view_button.dart';



class StartingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Fish Me",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Column(
            children: [
              SizedBox(
                height: size.height * 0.5,
              ),
              StartingViewButton(
                name: "LOGIN",
                background: Colors.black,
                splash: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogIn(),
                      ));
                },
              ),
              StartingViewButton(
                name: "SIGNUP",
                background: Colors.grey,
                splash: Colors.black,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ));
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
