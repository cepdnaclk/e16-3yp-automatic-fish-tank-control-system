import 'package:flutter/cupertino.dart';

import '../models/addtankmodel.dart';
import '../Repositories/addtankrepo.dart';
import '../Repositories/tankidrepo.dart';

abstract class SideBarEventS {}

class HomeEvent extends SideBarEventS {
  String email;
  TankIdRepo tankIdRepo;
  HomeEvent({@required this.email, @required this.tankIdRepo});
}

class MoreEvent extends SideBarEventS {}

class TankEvent extends SideBarEventS {}

class AddTankClickedEvent extends SideBarEventS {
  AddTankRepo addTankRepo;
  AddTankRequestModel addTankRequestModel;
  AddTankClickedEvent(
      {@required this.addTankRequestModel, @required this.addTankRepo});
}

class LoadingEvent extends SideBarEventS {
  final SideBarEventS nextevent;

  LoadingEvent({@required this.nextevent});

  SideBarEventS get nextEvent => this.nextevent;
}

class OneTankSelectedEvent extends SideBarEventS{
  String tankid;
  String email;
  OneTankSelectedEvent({@required this.tankid,@required this.email});
}
