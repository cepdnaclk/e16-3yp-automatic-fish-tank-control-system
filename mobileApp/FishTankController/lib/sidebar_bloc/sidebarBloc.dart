import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../sidebar_bloc/sidebarEvents.dart';
import '../sidebar_bloc/sidebarStates.dart';
import '../views/home.dart';
import '../views/redirect_view.dart';

class SideBarBloc extends Bloc<SideBarEventS, SideBarStates> {
  SideBarBloc(SideBarStates initialState) : super(initialState);

  @override
  Stream<SideBarStates> mapEventToState(SideBarEventS event) async* {
    // TODO: implement mapEventToState

    if (event is HomeEvent) {
      try {
        List<String> tankids = await event.tankIdRepo.tankIds(event.email);
        if (tankids != null) {
          yield HomeState(Home());
        } else {
          yield HomeState(RedirectView(
            email: event.email,
            isAuthenticatinFailed: true,
            topic: "Time Out",
            message: "Timeout in connection,Pleace login again..",
          ));
        }
      } catch (e) {
        yield HomeState(RedirectView(
          email: event.email,
          isAuthenticatinFailed: false,
          message: "Check your network connectivity and try agin..",
          topic: "Connection Failed",
        ));
      }
    } else if (event is MoreEvent) {
      yield MoreState();
    } else if (event is TankEvent) {
      yield TanksState();
    } else if (event is LoadingEvent) {
      yield LoadingState(
          homecolor: Colors.pink,
          logoutcolor: Colors.white,
          morecolor: Colors.white,
          tankcolor: Colors.white,
          event: event.nextEvent);
    }
  }
}
