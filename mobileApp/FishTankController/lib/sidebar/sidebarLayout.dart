import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../functions/onback_pressed.dart';
import '../Repositories/tankidrepo.dart';
import '../sidebar_bloc/sidebarBloc.dart';
import '../sidebar_bloc/sidebarEvents.dart';
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
    this.sideBarBloc = SideBarBloc(LoadingState(
        homecolor: Colors.pink,
        logoutcolor: Colors.white,
        morecolor: Colors.white,
        tankcolor: Colors.white,
        event: HomeEvent(email: widget.email, tankIdRepo: TankIdRepo())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackPressed(context,'Do you want to log out..'),
      child: BlocProvider(
        create: (context) => this.sideBarBloc,
        child: Scaffold(
          body: BlocBuilder<SideBarBloc, SideBarStates>(
            builder: (context, state) {
              if (state is LoadingState) {
                BlocProvider.of<SideBarBloc>(context).add(state.getEvent());
              }

              return Stack(
                children: [
                  state.updateView(),
                  SideBar(
                    fname: widget.fname,
                    lname: widget.lname,
                    email: widget.email,
                    isloading: state.isLoading(),
                  ),
                ],
              );
            },
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
