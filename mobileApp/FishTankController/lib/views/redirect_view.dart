import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../background/background.dart';
import '../functions/alert.dart';
import '../Repositories/tankidrepo.dart';
import '../sidebar_bloc/sidebarBloc.dart';
import '../sidebar_bloc/sidebarEvents.dart';

class RedirectView extends StatelessWidget {
  final String email;
  final String topic;
  final String message;
  final bool isAuthenticatinFailed;

  RedirectView(
      {@required this.email,
      @required this.topic,
      @required this.message,
      @required this.isAuthenticatinFailed});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((duration) async{
      if (this.isAuthenticatinFailed) {
        await logoutAlertMessage(context, this.topic, this.message);
        Navigator.of(context).pop(true);
      } else {
        alertMessage(context, this.topic, this.message);
      }
    });
    return Background(
        child: GestureDetector(
      onTap: () => BlocProvider.of<SideBarBloc>(context).add(LoadingEvent(
          nextevent: HomeEvent(email: this.email, tankIdRepo: TankIdRepo()))),
      child: Icon(
        Icons.restore,
        color: Colors.black87,
        size: 60,
      ),
    ));
  }
}
