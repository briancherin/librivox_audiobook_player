
import 'package:bloc/bloc.dart';
import 'package:librivox_audiobook_player/resources/blocs/authentication/authentication_state.dart';
import 'package:librivox_audiobook_player/resources/blocs/authentication/authentication_event.dart';
import 'package:librivox_audiobook_player/resources/models/models.dart';
import 'package:librivox_audiobook_player/resources/services/authentication_service.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;


  AuthenticationBloc(AuthenticationService authenticationService)
      : assert(authenticationService != null),
      _authenticationService = authenticationService,
      super(AuthenticationInitial());


  // TODO: add and assert authentication service

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState(event);
    }

    if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    }

    if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppLoadedToState(AppLoaded event) async* {
    yield AuthenticationLoading();
    try {
      final currentUser = await _authenticationService.getCurrentUser();

      yield AuthenticationAuthenticated(user: User(email: "TESTUSEREMAIL"));

      /*if (currentUser != null) {
        yield AuthenticationAuthenticated(user: currentUser);
      } else {
        yield AuthenticationNotAuthenticated();
      }
*/
    } catch (e) {
      yield AuthenticationFailure(message: e.message ?? 'Unknown error occurred.');
    }
  }

  Stream<AuthenticationState> _mapUserLoggedInToState(UserLoggedIn event) async* {
    yield AuthenticationAuthenticated(user: event.user);
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState(UserLoggedOut event) async* {
    await _authenticationService.signOut();
    yield AuthenticationNotAuthenticated();
  }



}