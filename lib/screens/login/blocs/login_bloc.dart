
import 'package:bloc/bloc.dart';
import 'package:librivox_audiobook_player/screens/login/blocs/login_event.dart';
import 'package:librivox_audiobook_player/screens/login/blocs/login_state.dart';
import 'package:librivox_audiobook_player/resources/blocs/authentication/authentication_bloc.dart';
import 'package:librivox_audiobook_player/resources/blocs/authentication/authentication_event.dart';
import 'package:librivox_audiobook_player/resources/services/authentication_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;

  LoginBloc(AuthenticationBloc authenticationBloc, AuthenticationService authenticationService) :
      assert(authenticationBloc != null),
      assert(authenticationService != null),
      _authenticationBloc = authenticationBloc,
      _authenticationService = authenticationService,
      super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithEmailButtonPressed) {
      yield* _mapLoginWithEmailButtonPressedToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithEmailButtonPressedToState(LoginWithEmailButtonPressed event) async* {
    yield LoginLoading();
    try {
      // TODO: sign in with user credentials specified in event
      final user = await _authenticationService.signInWithEmailAndPassword(event.email, event.password);

      if (user != null) {
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield LoginSuccess();
      } else {
        yield LoginFailure(error: "Login failed.");
      }
    } catch(e) {
      yield LoginFailure(error: e.message ?? 'Unknown error occurred');
    }
  }

}