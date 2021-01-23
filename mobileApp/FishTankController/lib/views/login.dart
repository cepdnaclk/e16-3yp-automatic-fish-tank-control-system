import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebar/blocs/loginbloc/loginbloc.dart';

import '../blocs/loginbloc/loginstates.dart';
import '../Repositories/loginrepo.dart';
import '../views/login_view.dart';
import '../views/spine_view.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(LoginInitialState(), LoginRepo()),
      child: BlocBuilder<LoginBloc, LoginStates>(
        builder: (context, state){
          if (state is LoginInitialState) {
            return LoginView();
          } else if (state is CallLoginstate) {
            return SpineView();
          }
        },
      ),
    );
  }
}
