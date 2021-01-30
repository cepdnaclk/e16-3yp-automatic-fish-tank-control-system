import 'package:flutter/cupertino.dart';
import '../Repositories/tankidrepo.dart';

abstract class SideBarEventS {}

class HomeEvent extends SideBarEventS {
  String email;
  TankIdRepo tankIdRepo;
  HomeEvent({@required this.email, @required this.tankIdRepo});
}

class MoreEvent extends SideBarEventS {}

class TankEvent extends SideBarEventS {}

class AddTankClickedEvent extends SideBarEventS {}

class LoadingEvent extends SideBarEventS {
  final SideBarEventS nextevent;

  LoadingEvent({@required this.nextevent});

  SideBarEventS get nextEvent => this.nextevent;
}
