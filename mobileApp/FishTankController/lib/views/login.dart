import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebar/blocs/loginbloc/loginbloc.dart';

import '../blocs/loginbloc/loginstates.dart';
import '../Repositories/loginrepo.dart';
import '../sidebar/sidebarLayout.dart';
import '../views/login_view.dart';
import '../views/spine_view.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(LoginInitialState(), LoginRepo()),
      child: BlocBuilder<LoginBloc, LoginStates>(
        builder: (context, state) {
          if (state is LoginInitialState) {
            return LoginView(
              alertstatus: false,
            );
          } else if (state is CallLoginstate) {
            return SpineView();
          } else if (state is ConnectionErrorState) {
            return LoginView(
              alertstatus: true,
              topic: "Connection Failed",
              message: "Something wrong with connection,check network",
            );
          } else if (state is LoggedState) {
            return SideBarLayout(
              email: state.email,
              fname: state.fname,
              lname: state.lname,
            );
          } else if (state is LoginFailedState) {
            return LoginView(
              alertstatus: true,
              topic: "Login Failed",
              message: "Your Password or username is wrong...",
            );
          }
        },
      ),
    );
  }
}
