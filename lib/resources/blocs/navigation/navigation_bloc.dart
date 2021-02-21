

import 'package:bloc/bloc.dart';
import 'package:librivox_audiobook_player/resources/blocs/navigation/navigation_event.dart';
import 'package:librivox_audiobook_player/resources/blocs/navigation/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(ShowLibrary());

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is UserClickedLibrary) {
      yield ShowLibrary();
    }
    else if (event is UserClickedCatalog) {
      yield ShowCatalog();
    }
  }

}