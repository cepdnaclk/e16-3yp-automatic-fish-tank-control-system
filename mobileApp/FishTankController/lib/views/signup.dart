import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/signupbloc/signup_state.dart';
import '../blocs/signupbloc/signupbloc.dart';
import '../Repositories/signuprepo.dart';
import '../views/signup_view.dart';
import '../views/spine_view.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(SignUpInitialState(), SignupRepo()),
      child: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          if (state is SignUpInitialState) {
            return SignupView(status: false,);
          } else if (state is SignUpCalledState) {
            return SpineView();
          } else if (state is SignupFailedState) {
            return SignupView(
              status: true,
              topic: "Sign Up Failed",
              message: "Sign up is failed ,check your email",
            );
          } else if (state is SignupedState) {
            return SignupView(
              status: true,
              topic: "Done",
              message: "Sign up copleted ,you can log in now",
            );
          } else if (state is ConnectionErrorState) {
            return SignupView(
              status: true,
              topic: "Connection Error",
              message: "Check your network connection",
            );
          }
        },
      ),
    );
  }
}
