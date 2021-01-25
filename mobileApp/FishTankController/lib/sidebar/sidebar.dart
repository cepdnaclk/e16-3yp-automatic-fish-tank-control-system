import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../sidebar/sidebarItem.dart';
import '../sidebar_bloc/sidebarBloc.dart';
import '../sidebar_bloc/sidebarEvents.dart';
import '../sidebar_bloc/sidebarStates.dart';

class SideBar extends StatefulWidget {
  final String fname;
  final String lname;
  final String email;
  SideBar({this.fname, this.lname, this.email});

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final _animationDuration = Duration(milliseconds: 250);
  bool logout = false;

  var screenWidth;
  bool isclickedSidebar = false;

  void openSideBar() async {
    setState(() {
      this.isclickedSidebar = !this.isclickedSidebar;
    });
  }

  @override
  Widget build(BuildContext context) {
    this.screenWidth = MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      duration: this._animationDuration,
      top: 0,
      curve: Curves.linear,
      bottom: 0,
      left: this.isclickedSidebar ? 0 : -this.screenWidth,
      right: this.isclickedSidebar ? 0 : this.screenWidth - 34,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  ListTile(
                    title: Text(
                      widget.fname + " " + widget.lname,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    subtitle: Text(widget.email,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.perm_identity),
                      radius: 30,
                    ),
                  ),
                  Divider(
                    height: 64,
                    thickness: 1,
                    color: Colors.white,
                    endIndent: 20,
                    indent: 20,
                  ),
                  BlocBuilder<SideBarBloc, SideBarStates>(
                    builder: (context, state) => SideBarItem(
                      iconData: Icons.home,
                      itemName: "Home",
                      ontap: () {
                        BlocProvider.of<SideBarBloc>(context).add(HomeEvent());
                        this.openSideBar();
                      },
                      color: state.homeColor(),
                    ),
                  ),
                  BlocBuilder<SideBarBloc, SideBarStates>(
                    builder: (context, state) => SideBarItem(
                      iconData: Icons.bar_chart,
                      itemName: "Tanks",
                      ontap: () {
                        BlocProvider.of<SideBarBloc>(context).add(TankEvent());
                        this.openSideBar();
                      },
                      color: state.tankColor(),
                    ),
                  ),
                  BlocBuilder<SideBarBloc, SideBarStates>(
                    builder: (context, state) => SideBarItem(
                      iconData: Icons.add,
                      itemName: "More",
                      ontap: () {
                        BlocProvider.of<SideBarBloc>(context).add(MoreEvent());
                        this.openSideBar();
                      },
                      color: state.moreColor(),
                    ),
                  ),
                  BlocBuilder<SideBarBloc, SideBarStates>(
                    builder: (context, state) => SideBarItem(
                      iconData: Icons.logout,
                      itemName: "Log Out",
                      ontap: () async {
                        await onLogoutPresed(context);
                        if (this.logout) {
                          Navigator.of(context).pop(true);
                        }
                      },
                      color: state.logoutColor(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.8),
            child: Container(
              width: 38,
              height: 100,
              color: Colors.black,
              child: IconButton(
                icon: Icon(
                  this.isclickedSidebar ? Icons.cancel : Icons.menu,
                  color: Colors.white,
                ),
                onPressed: this.openSideBar,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> onLogoutPresed(BuildContext context) {
    return showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to log out..'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text(
                  "NO",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () {
                  this.logout = true;
                  return Navigator.of(context).pop(true);
                },
                child: Text("YES",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ) ??
        false;
  }
}
