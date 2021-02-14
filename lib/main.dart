import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librivox_audiobook_player/pages/home_screen.dart';
import 'package:librivox_audiobook_player/pages/login/login_screen.dart';
import 'package:librivox_audiobook_player/resources/blocs/authentication/authentication%20state.dart';
import 'package:librivox_audiobook_player/resources/blocs/authentication/authentication_bloc.dart';
import 'package:librivox_audiobook_player/resources/blocs/authentication/authentication_event.dart';

import 'resources/services/services.dart';

void main() {
  runApp(
    RepositoryProvider<AuthenticationService>(
      create: (context) {
        return AuthenticationService();
      },
      child:
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            final authService = RepositoryProvider.of<AuthenticationService>(context);
            return AuthenticationBloc(authService)..add(AppLoaded());
          },
          child: MyApp()
        )
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Librivox Audiobook Player',
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if(state is AuthenticationAuthenticated) {
            return HomeScreen(user: state.user);
          }
          return LoginScreen();
        }
      )
    );
  }
}
