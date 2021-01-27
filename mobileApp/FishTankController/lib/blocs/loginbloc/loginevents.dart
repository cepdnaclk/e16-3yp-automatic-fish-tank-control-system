import 'package:sidebar/models/loginmodel.dart';

abstract class LoginEvents {}

class CallLoginEvent extends LoginEvents {
  final LoginRequestModel loginRequestModel;

  CallLoginEvent(this.loginRequestModel);

  LoginRequestModel get data => this.loginRequestModel;
}


