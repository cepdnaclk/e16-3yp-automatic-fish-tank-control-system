import 'package:flutter/material.dart';

import '../background/background.dart';
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Text(
                "Fish Tank Controller",
                style: TextStyle(
                    fontFamily: 'SquadaOne',
                    fontWeight: FontWeight.bold,
                    fontSize: 50),
                    textAlign: TextAlign.center,
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
              StartingViewButton(
                name: "LOGIN",
                background: Colors.black54,
                splash: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) {
                          return LogIn();
                        },
                      ));
                },
              ),
              StartingViewButton(
                name: "SIGNUP",
                background: Colors.grey[200],
                splash: Colors.black,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
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
