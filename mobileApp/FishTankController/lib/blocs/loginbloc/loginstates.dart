import 'package:sidebar/models/loginmodel.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class CallLoginstate extends LoginStates {}

class LoginFailedState extends LoginStates {}

class ConnectionErrorState extends LoginStates {}

class LoggedState extends LoginStates {
  final LoginResponseModel loginResponseModel;

  LoggedState(this.loginResponseModel);

  String get email=>this.loginResponseModel.email;

  String get fname=>this.loginResponseModel.fname;

  String get lname=>this.loginResponseModel.lname;

}
