import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../sidebar_bloc/sidebarBloc.dart';
import '../sidebar_bloc/sidebarStates.dart';
import 'sidebar.dart';

class SideBarLayout extends StatefulWidget {
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
    return BlocProvider(
      create: (context) => this.sideBarBloc,
      child: Stack(
        children: [
          BlocBuilder<SideBarBloc, SideBarStates>(
            builder: (context, state) {
              return state.updateView();
            },
          ),
          SideBar(),
        ],
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
