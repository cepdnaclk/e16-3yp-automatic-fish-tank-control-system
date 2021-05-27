import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../background/background.dart';
import '../constants.dart';
import 'fish_detail_view.dart';
import '../functions/alert.dart';
import '../models/fishnamemodel.dart';
import '../models/graphmodel.dart';
import '../Repositories/controlerrepo.dart';
import '../Repositories/getfishnames.dart';
import '../Repositories/graphrepo.dart';
import '../Repositories/tankidrepo.dart';
import '../sidebar_bloc/sidebarBloc.dart';
import '../sidebar_bloc/sidebarEvents.dart';
import '../views/spine_view.dart';
import '../views/graph_view.dart';

class OneTankView extends StatefulWidget {
  final String tankid;
  final String email;
  OneTankView({@required this.tankid, @required this.email});

  @override
  _OneTankViewState createState() => _OneTankViewState();
}

class _OneTankViewState extends State<OneTankView> {
  GraphRepo graphRepo;
  GetFishNameRepo getFishNameRepo;
  ControllerRepo controllerRepo;
  bool isreloading = false;
  bool weeklyDataStatus = false;
  GraphResponseModel graphResponseModel;

  @override
  void initState() {
    // TODO: implement initState
    this.graphRepo = GraphRepo();
    this.getFishNameRepo = GetFishNameRepo();
    this.controllerRepo = ControllerRepo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (this.isreloading) {
      return SpineView();
    } else {
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
                    widget.tankid,
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
              onPressed: () => this.WeeklyStatus("3d"),
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
              onPressed: () async => this.fishDetailHandler(context),
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
              onPressed: () async => this.controlHandler(context, FEEDNOW),
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
              onPressed: () async => this.controlHandler(context, RENEW),
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
                          email: widget.email, tankIdRepo: TankIdRepo()))),
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

  void fishDetailHandler(BuildContext context) async {
    setState(() {
      this.isreloading = true;
    });
    try {
      FishNameResponseModel fishNameResponseModel = await this
          .getFishNameRepo
          .findFishNames(FishNameRequestModel(widget.tankid));
      setState(() {
        this.isreloading = false;
      });
      if (fishNameResponseModel == null) {
        await logoutAlertMessage(context, "Time Out",
            "Your session is time out..pleace login again..");
        Navigator.of(context).pop(true);
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => FishDetailView(
                fishcount: fishNameResponseModel.fishcounts,
                fishnames: fishNameResponseModel.fishnames,
              ),
            ));
      }
    } catch (e) {
      setState(() {
        this.isreloading = false;
      });
      alertMessage(
          context, "Connection Failed", "Check your network connection....");
    }
  }

  Future<void> controlHandler(BuildContext context, String url) async {
    setState(() {
      this.isreloading = true;
    });
    try {
      bool status = await this
          .controllerRepo
          .sendControl(FishNameRequestModel(widget.tankid), url);
      setState(() {
        this.isreloading = false;
      });
      if (status) {
        alertMessage(context, "Done", "you have sussefully done...");
      } else {
        await logoutAlertMessage(context, "Time Out",
            "Your session is time out..pleace login again..");
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      setState(() {
        this.isreloading = false;
      });
      alertMessage(
          context, "Connection Failed", "Check your network connection....");
    }
  }

  void WeeklyStatus(String day) async {
    // List<TimeSeriesPh> phDataArray = [
    //   TimeSeriesPh(new DateTime(2021, 9, 19), 10),
    //   TimeSeriesPh(new DateTime(2021, 9, 21), 11),
    //   TimeSeriesPh(new DateTime(2021, 9, 22), 25),
    //   TimeSeriesPh(new DateTime(2021, 9, 23), 50),
    //   TimeSeriesPh(new DateTime(2021, 9, 24), 55)
    // ];
    // List<TimeSeriesTemp> tempDataArray = [
    //   TimeSeriesTemp(new DateTime(2021, 9, 19), 10),
    //   TimeSeriesTemp(new DateTime(2021, 9, 21), 11),
    //   TimeSeriesTemp(new DateTime(2021, 9, 22), 25),
    //   TimeSeriesTemp(new DateTime(2021, 9, 23), 50),
    //   TimeSeriesTemp(new DateTime(2021, 9, 24), 55)
    // ];
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       fullscreenDialog: true,
    //       builder: (context) => GraphView(
    //         phDataArray: phDataArray,
    //         tempDataArray: tempDataArray,
    //       ),
    //     ));
    setState(() {
      this.isreloading = true;
    });
    try {
      GraphResponseModel graphResponseModel =
          await this.graphRepo.getphGraph(day, widget.email, widget.tankid);
      setState(() {
        this.isreloading = false;
      });
      print( graphResponseModel.phlist);
      if (graphResponseModel != null) {
        this.graphResponseModel = graphResponseModel;
        this.weeklyDataStatus = true;
        Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => GraphView(
                phDataArray: graphResponseModel.phlist,
                tempDataArray: graphResponseModel.templist,
              ),
            ));
      } else {
        await logoutAlertMessage(context, "Time Out",
            "Your session is time out..pleace login again..");
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      print(e);
      setState(() {
        this.isreloading = false;
      });
      alertMessage(
          context, "Connection Failed", "Check your network connection....");
    }
  }
}
