import 'package:flutter/material.dart';

import '../views/home.dart';
import '../views/more.dart';
import '../views/tanks.dart';

abstract class SideBarStates {
  Color homeColor();
  Color tankColor();
  Color moreColor();
  Color logoutColor();
  Widget updateView();
}

class HomeState extends SideBarStates {
  @override
  Widget updateView() {
    // TODO: implement updateView
    return Home();
  }

  @override
  Color homeColor() {
    // TODO: implement homeColor
    return Colors.pink;
  }

  @override
  Color logoutColor() {
    // TODO: implement logoutColor
    return Colors.white;
  }

  @override
  Color moreColor() {
    // TODO: implement moreColor
    return Colors.white;
  }

  @override
  Color tankColor() {
    // TODO: implement tankColor
    return Colors.white;
  }
}

class TanksState extends SideBarStates {
  @override
  Widget updateView() {
    // TODO: implement updateView
    return Tanks();
  }

  @override
  Color homeColor() {
    // TODO: implement homeColor
    return Colors.white;
  }

  @override
  Color logoutColor() {
    // TODO: implement logoutColor
    return Colors.white;
  }

  @override
  Color moreColor() {
    // TODO: implement moreColor
    return Colors.white;
  }

  @override
  Color tankColor() {
    // TODO: implement tankColor
    return Colors.pink;
  }
}

class MoreState extends SideBarStates {
  @override
  Widget updateView() {
    // TODO: implement updateView
    return More();
  }

  @override
  Color homeColor() {
    // TODO: implement homeColor
    return Colors.white;
  }

  @override
  Color logoutColor() {
    // TODO: implement logoutColor
    return Colors.white;
  }

  @override
  Color moreColor() {
    // TODO: implement moreColor
    return Colors.pink;
  }

  @override
  Color tankColor() {
    // TODO: implement tankColor
    return Colors.white;
  }
}
