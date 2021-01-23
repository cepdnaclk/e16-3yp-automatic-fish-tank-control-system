import 'package:sidebar/models/signupmodel.dart';

abstract class SignupEvents {}

class CallSignupEvent extends SignupEvents {
  final SignupRequestModel signupRequestModel;

  CallSignupEvent(this.signupRequestModel);

  SignupRequestModel get data => this.signupRequestModel;
}
