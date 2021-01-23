import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebar/sidebar_bloc/sidebarStates.dart';

import '../sidebar/sidebarItem.dart';
import '../sidebar_bloc/sidebarBloc.dart';
import '../sidebar_bloc/sidebarEvents.dart';

class SideBar extends StatefulWidget {
  final String fname;
  final String lname;
  final String email;
  SideBar({this.fname, this.lname, this.email});

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final _animationDuration = Duration(milliseconds: 500);

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
                    subtitle: Text(widget.lname,
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
                      ontap: () {
                        BlocProvider.of<SideBarBloc>(context)
                            .add(LogOutEvent());
                        this.openSideBar();
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
}

// mixin StreamController {}
