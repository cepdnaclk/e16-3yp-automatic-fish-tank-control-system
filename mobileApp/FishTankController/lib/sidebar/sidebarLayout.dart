import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../functions/onback_pressed.dart';
import '../sidebar_bloc/sidebarBloc.dart';
import '../sidebar_bloc/sidebarStates.dart';
import 'sidebar.dart';

class SideBarLayout extends StatefulWidget {
  final String fname;
  final String lname;
  final String email;

  SideBarLayout({this.fname, this.lname, this.email});

  @override
  _SideBarLayoutState createState() => _SideBarLayoutState();
}

class _SideBarLayoutState extends State<SideBarLayout> {
  SideBarBloc sideBarBloc;

  @override
  void initState() {
    // TODO: implement initState
    this.sideBarBloc = SideBarBloc(HomeState());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackPressed(context),
      child: BlocProvider(
        create: (context) => this.sideBarBloc,
        child: Scaffold(
          body: Stack(
            children: [
              BlocBuilder<SideBarBloc, SideBarStates>(
                builder: (context, state) {
                  return state.updateView();
                },
              ),
              SideBar(
                fname: widget.fname,
                lname: widget.lname,
                email: widget.email,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    this.sideBarBloc.close();
    super.dispose();
  }

  
}
