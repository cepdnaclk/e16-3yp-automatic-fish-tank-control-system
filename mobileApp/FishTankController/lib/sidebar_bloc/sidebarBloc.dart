import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Repositories/addtankrepo.dart';
import '../sidebar_bloc/sidebarEvents.dart';
import '../sidebar_bloc/sidebarStates.dart';
import '../views/home.dart';
import '../views/redirect_view.dart';
import '../Repositories/tankidrepo.dart';
import '../views/onetank_view.dart';

class SideBarBloc extends Bloc<SideBarEventS, SideBarStates> {
  SideBarBloc(SideBarStates initialState) : super(initialState);

  @override
  Stream<SideBarStates> mapEventToState(SideBarEventS event) async* {
    // TODO: implement mapEventToState

    if (event is HomeEvent) {
      try {
        List<String> tankids = await event.tankIdRepo.tankIds(event.email);
        if (tankids != null) {
          if (tankids.length == 0) {
            yield HomeState(RedirectView(
              email: event.email,
              isAuthenticatinFailed: false,
              message: "Hey,you haven't added tanks yet..",
              topic: "NO TANK",
            ));
          } else {
            yield HomeState(Home(
              idarray: tankids,
              email: event.email,
            ));
          }
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
    } else if (event is OneTankSelectedEvent) {
      yield HomeState(OneTankView(
        tankid: event.tankid,
        email: event.email,
      ));
    } else if (event is MoreEvent) {
      yield MoreState();
    } else if (event is TankEvent) {
      yield TanksState(isshowMessage: false);
    } else if (event is LoadingEvent) {
      yield LoadingState(
          homecolor: Colors.pink,
          logoutcolor: Colors.white,
          morecolor: Colors.white,
          tankcolor: Colors.white,
          event: event.nextEvent);
    } else if (event is AddTankClickedEvent) {
      try {
        AddTankStatus status =
            await event.addTankRepo.addTank(event.addTankRequestModel);
        if (status.authfail) {
          yield TanksState(
              isshowMessage: true,
              isAuthFailed: true,
              topic: "TimeOut",
              message: "Your session is time out,please login again..");
        } else if (!status.authfail && !status.wrongid) {
          yield TanksState(
              isshowMessage: true,
              topic: "Done",
              isAuthFailed: false,
              message: "Successfully added a tank..");
        } else if (status.authfail && status.wrongid) {
          yield TanksState(
              isshowMessage: true,
              topic: "Error",
              isAuthFailed: false,
              message: "Something wrong, please try again later..");
        } else if (status.wrongid) {
          yield TanksState(
              isshowMessage: true,
              isAuthFailed: false,
              topic: "Wrong Id",
              message: "You entered ,id is wrong..");
        }
      } catch (e) {
        yield TanksState(
            isshowMessage: true,
            isAuthFailed: false,
            topic: "Connection Failed",
            message: "Connection failed,check your network connection..");
      }
    } else if (event is DeleteTankEvent) {
      try {
        await event.deleteTankRepo.deleteTank(event.deleteTankRequestModel);
      } catch (e) {}
      yield LoadingState(
          homecolor: Colors.pink,
          logoutcolor: Colors.white,
          morecolor: Colors.white,
          tankcolor: Colors.white,
          event: HomeEvent(
              email: event.deleteTankRequestModel.email,
              tankIdRepo: TankIdRepo()));
    }
  }
}
