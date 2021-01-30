import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../background/background.dart';
import '../Repositories/tankidrepo.dart';
import '../sidebar_bloc/sidebarBloc.dart';
import '../sidebar_bloc/sidebarEvents.dart';

class OneTankView extends StatelessWidget {
  final String tankid;
  final String email;

  OneTankView({@required this.tankid, @required this.email});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          Container(
            height: size.height * 0.1,
            width: size.width * 0.8,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.blueGrey[900],
                borderRadius: BorderRadius.circular(50)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "TANK ID",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
                Text(
                  this.tankid,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                )
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.09,
          ),
          RaisedButton(
            elevation: 10.0,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.2, vertical: 10),
            color: Colors.blueGrey,
            onPressed: () => null,
            child: Text(
              "WEEKLY STATUS",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          RaisedButton(
            elevation: 10.0,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.2, vertical: 10),
            color: Colors.blueGrey,
            onPressed: () => null,
            child: Text(
              "FISH DETAILS",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          RaisedButton(
            elevation: 10.0,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.2, vertical: 10),
            color: Colors.blueGrey,
            onPressed: () => null,
            child: Text(
              "FEED NOW",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          RaisedButton(
            elevation: 10.0,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.25, vertical: 10),
            color: Colors.blueGrey,
            onPressed: () => null,
            child: Text(
              "RENEW NOW",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 23,
          ),
          RaisedButton(
            elevation: 10.0,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.3, vertical: 10),
            color: Colors.black,
            onPressed: () => BlocProvider.of<SideBarBloc>(context).add(
                LoadingEvent(
                    nextevent: HomeEvent(
                        email: this.email, tankIdRepo: TankIdRepo()))),
            child: Text(
              "BACK",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    ));
  }
}
