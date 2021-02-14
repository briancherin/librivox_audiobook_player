
import 'package:equatable/equatable.dart';
import 'package:librivox_audiobook_player/resources/models/models.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// Initial event when app is loaded
class AppLoaded extends AuthenticationEvent {}

// User successfully logged in
class UserLoggedIn extends AuthenticationEvent {
  final User user;

  UserLoggedIn({@required this.user});

  @override
  List<Object> get props => [user];
}

// User logged out
class UserLoggedOut extends AuthenticationEvent {}