import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebar/Repositories/loginrepo.dart';

import './loginevents.dart';
import './loginstates.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginRepo loginRepo;

  LoginBloc(LoginStates initialState, this.loginRepo) : super(initialState);

  @override
  Stream<LoginStates> mapEventToState(LoginEvents event) async* {
    // TODO: implement mapEventToState
    String token;
    if (event is CallLoginEvent) {
      yield CallLoginstate();
      try {
        token = await this.loginRepo.login(event.data);

        if (token.isEmpty) {
          yield LoginFailedState();
        } else {
          yield LoggedState(event.data);
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('token', token);
        }
      } catch (e) {
        yield CallLoginstate();
      }
    }
  }
}
