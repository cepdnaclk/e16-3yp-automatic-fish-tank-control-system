import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../background/background.dart';
import '../functions/alert.dart';
import '../models/addtankmodel.dart';
import '../Repositories/addtankrepo.dart';
import '../sidebar_bloc/sidebarBloc.dart';
import '../sidebar_bloc/sidebarEvents.dart';

class Tanks extends StatefulWidget {
  final bool isAuthfailed;
  final String message;
  final String topic;
  bool showMessage;

  Tanks(
      {this.isAuthfailed,
      this.message,
      this.topic,
      @required this.showMessage});

  @override
  _TanksState createState() => _TanksState();
}

class _TanksState extends State<Tanks> {
  String phonenumber;
  String tankid;
  String email;
  int height;
  int width;
  int length;

  int noofaddwidgests = 0;
  List<String> fishnames = [
    "",
  ];
  List<int> fishcount = [
    0,
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((duration) async {
      if (widget.showMessage) {
        if (widget.isAuthfailed) {
          await logoutAlertMessage(context, widget.topic, widget.message);
          Navigator.of(context).pop(true);
        } else {
          alertMessage(context, widget.topic, widget.message);
        }
        widget.showMessage = false;
      }
    });

    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.2,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: TextField(
                onChanged: (value) {
                  this.tankid = value;
                },
                decoration: InputDecoration(
                    hintText: "Tank ID",
                    helperText: "Enter your tank id here..",
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal))),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: TextField(
                onChanged: (value) {
                  this.phonenumber = value;
                },
                decoration: InputDecoration(
                    hintText: "WhatsApp Number",
                    helperText: "Enter your whatsapp number here..",
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal))),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: TextField(
                onChanged: (value) {
                  this.email = value;
                },
                decoration: InputDecoration(
                    hintText: "Email",
                    helperText: "Enter your account email here..",
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal))),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  this.height = int.parse(value);
                },
                decoration: InputDecoration(
                    hintText: "Height",
                    helperText: "Enter your tank height  here..",
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal))),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  this.width = int.parse(value);
                },
                decoration: InputDecoration(
                    hintText: "Width",
                    helperText: "Enter your tank width here..",
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal))),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  this.length = int.parse(value);
                },
                decoration: InputDecoration(
                    hintText: "Length",
                    helperText: "Enter your tank length here..",
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal))),
              ),
            ),
            ...this.addFishCountWidgets(size),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.3,
                  ),
                  IconButton(
                    iconSize: 20,
                    icon: Icon(
                      MdiIcons.cardRemove,
                      size: 50,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        if (this.noofaddwidgests > 0) {
                          this.noofaddwidgests--;
                          this.fishnames.removeLast();
                          this.fishcount.removeLast();
                        }
                      });
                    },
                  ),
                  SizedBox(
                    width: size.width * 0.08,
                  ),
                  IconButton(
                    highlightColor: Colors.green,
                    iconSize: 21,
                    icon: Icon(
                      MdiIcons.basketPlus,
                      size: 49,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        this.noofaddwidgests++;
                        this.fishnames.add("");
                        this.fishcount.add(0);
                      });
                    },
                  ),
                ]),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              color: Colors.grey,
              onPressed: () => BlocProvider.of<SideBarBloc>(context).add(
                  LoadingEvent(
                      nextevent: AddTankClickedEvent(
                          addTankRepo: AddTankRepo(),
                          addTankRequestModel: AddTankRequestModel(
                              phone_no: this.phonenumber,
                              device_id: this.tankid,
                              email: this.email,
                              fish_count: this.fishcount,
                              fish_names: this.fishnames,
                              height: this.height,
                              lenght: this.length,
                              width: this.width)))),
              child: Text(
                "SAVE",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.2, vertical: 10),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> addFishCountWidgets(Size size) {
    List<Widget> list = [];

    for (var i = 0; i < this.noofaddwidgests + 1; i++) {
      list.add(Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: size.width * 0.5,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: TextField(
              onChanged: (value) {
                this.fishnames[i] = value;
              },
              decoration: InputDecoration(
                  hintText: "Fish Name",
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal))),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: size.width * 0.3,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                this.fishcount[i] = int.parse(value);
              },
              decoration: InputDecoration(
                  hintText: "Count",
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal))),
            ),
          ),
        ],
      ));
    }

    return list;
  }
}
