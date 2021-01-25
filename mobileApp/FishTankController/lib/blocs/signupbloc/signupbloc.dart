import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebar/Repositories/signuprepo.dart';
import 'package:sidebar/blocs/signupbloc/signup_events.dart';
import 'package:sidebar/blocs/signupbloc/signup_state.dart';

class SignupBloc extends Bloc<SignupEvents, SignupState> {
  SignupRepo signupRepo;
  SignupBloc(initialState, this.signupRepo) : super(initialState);

  @override
  Stream<SignupState> mapEventToState(SignupEvents event) async* {
    // TODO: implement mapEventToState
    if (event is CallSignupEvent) {
      yield SignUpCalledState();
      try {
        final result = await this.signupRepo.signup(event.data);
        if (result) {
          yield SignupedState();
        } else {
          yield SignupFailedState();
        }
      } catch (e) {
        yield ConnectionErrorState();
      }
    }
  }
}
