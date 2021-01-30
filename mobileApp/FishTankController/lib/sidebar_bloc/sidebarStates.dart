import 'package:flutter/material.dart';

import '../sidebar_bloc/sidebarEvents.dart';
import '../views/home.dart';
import '../views/more.dart';
import '../views/spine_view.dart';
import '../views/tanks.dart';

abstract class SideBarStates {
  Color homeColor();
  Color tankColor();
  Color moreColor();
  Color logoutColor();
  bool isLoading();
  Widget updateView();
}

class HomeState extends SideBarStates {
  Widget widget;
  HomeState(this.widget);
  @override
  Widget updateView() {
    // TODO: implement updateView
    return this.widget;
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

  @override
  bool isLoading() {
    // TODO: implement isLoading
    return false;
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

  @override
  bool isLoading() {
    // TODO: implement isLoading
    return false;
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

  @override
  bool isLoading() {
    // TODO: implement isLoading
    return false;
  }
}

class LoadingState extends SideBarStates {
  Color homecolor;
  Color logoutcolor;
  Color morecolor;
  Color tankcolor;
  SideBarEventS event;

  LoadingState(
      {@required this.homecolor,
      @required this.logoutcolor,
      @required this.morecolor,
      @required this.tankcolor,
      @required this.event});

  @override
  Color homeColor() {
    // TODO: implement homeColor
    return this.homecolor;
  }

  @override
  Color logoutColor() {
    // TODO: implement logoutColor
    return this.logoutcolor;
  }

  @override
  Color moreColor() {
    // TODO: implement moreColor
    return this.morecolor;
  }

  @override
  Color tankColor() {
    // TODO: implement tankColor
    return this.tankcolor;
  }

  @override
  Widget updateView() {
    // TODO: implement updateView
    return SpineView();
  }

  SideBarEventS getEvent() {
    return this.event;
  }

  @override
  bool isLoading() {
    // TODO: implement isLoading
    return true;
  }
}
