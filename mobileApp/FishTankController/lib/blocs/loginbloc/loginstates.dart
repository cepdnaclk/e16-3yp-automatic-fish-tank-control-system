import 'package:sidebar/models/loginmodel.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class CallLoginstate extends LoginStates {}

class LoginFailedState extends LoginStates {}

class ConnectionErrorState extends LoginStates {}

class LoggedState extends LoginStates {
  final LoginRequestModel loginRequestModel;

  LoggedState(this.loginRequestModel);

  String get email=>this.loginRequestModel.email;

}
