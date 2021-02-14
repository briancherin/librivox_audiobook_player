import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:librivox_audiobook_player/resources/models/models.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationNotAuthenticated extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final User user;

  AuthenticationAuthenticated({@required this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure({@required this.message});

  @override
  List<Object> get props => [message];
}