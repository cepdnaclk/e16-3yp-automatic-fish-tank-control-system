import 'package:bloc/bloc.dart';
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
      } catch (e) {
        yield ConnectionErrorState();
      }
      if (token.isEmpty) {
        yield LoginFailedState();
      }else{
        yield LoggedState(event.data);
      }
    }
  }
}
