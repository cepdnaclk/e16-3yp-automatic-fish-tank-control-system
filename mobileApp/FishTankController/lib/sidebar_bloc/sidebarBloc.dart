import 'package:flutter_bloc/flutter_bloc.dart';

import '../sidebar_bloc/sidebarEvents.dart';
import '../sidebar_bloc/sidebarStates.dart';

class SideBarBloc extends Bloc<SideBarEventS, SideBarStates> {
  SideBarBloc(SideBarStates initialState) : super(initialState);

  @override
  Stream<SideBarStates> mapEventToState(SideBarEventS event) async* {
    // TODO: implement mapEventToState

    if (event is HomeEvent) {
      yield HomeState();
    } else if (event is MoreEvent) {
      yield MoreState();
    } else if (event is TankEvent) {
      yield TanksState();
    }
  }
}
