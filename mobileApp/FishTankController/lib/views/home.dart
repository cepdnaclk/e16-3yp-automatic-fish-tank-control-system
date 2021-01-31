import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebar/functions/onback_pressed.dart';

import '../background/background.dart';
import '../models/deletetankmodel.dart';
import '../Repositories/deletetankrepo.dart';
import '../sidebar_bloc/sidebarBloc.dart';
import '../sidebar_bloc/sidebarEvents.dart';

class Home extends StatefulWidget {
  List<String> idarray;
  String email;
  Home({@required this.idarray, @required this.email});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            ...setTankIdButtons(widget.idarray, size)
          ],
        ),
      ),
    );
  }

  List<Widget> setTankIdButtons(List<String> list, Size size) {
    List<Widget> widgetlist = [];

    for (var item in list) {
      widgetlist.add(
        RaisedButton(
          onLongPress: () async {
            if (await onBackPressed(
                context, 'Do you want to delete this id?')) {
              BlocProvider.of<SideBarBloc>(context).add(LoadingEvent(
                nextevent: DeleteTankEvent(
                    deleteTankRepo: DeleteTankRepo(),
                    deleteTankRequestModel: DeleteTankRequestModel(
                        device_id: item, email: widget.email)),
              ));
            }
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.black)),
          elevation: 6,
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.2, vertical: 10),
          onPressed: () => BlocProvider.of<SideBarBloc>(context)
              .add(OneTankSelectedEvent(tankid: item, email: widget.email)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "TANK ID",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                item,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              )
            ],
          ),
        ),
      );

      widgetlist.add(SizedBox(
        height: 15,
      ));
    }

    return widgetlist;
  }
}
