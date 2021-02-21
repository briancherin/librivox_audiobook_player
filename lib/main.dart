import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librivox_audiobook_player/resources/audiobook_repository.dart';
import 'package:librivox_audiobook_player/resources/blocs/navigation/navigation_bloc.dart';
import 'package:librivox_audiobook_player/screens/app_screen.dart';
import 'package:librivox_audiobook_player/screens/catalog/blocs/catalog_bloc.dart';
import 'package:librivox_audiobook_player/screens/catalog/catalog.dart';
import 'package:librivox_audiobook_player/screens/login/login.dart';
import 'package:librivox_audiobook_player/resources/blocs/authentication/authentication_state.dart';
import 'package:librivox_audiobook_player/resources/blocs/authentication/authentication_bloc.dart';
import 'package:librivox_audiobook_player/resources/blocs/authentication/authentication_event.dart';

import 'resources/services/services.dart';
import 'screens/catalog/blocs/catalog_event.dart';

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
            return BlocProvider<NavigationBloc>(
              create: (context) {
                return NavigationBloc();
              },
              child: AppScreen()
            );
            return AppScreen();
            /*return BlocProvider<CatalogBloc>(
              create: (context) {
                final AudiobookRepository audiobookRepository = AudiobookRepository();
                return CatalogBloc(audiobookRepository)..add(CatalogOpened());
              },
              child: CatalogScreen()
            );*/
          }
          return LoginScreen();
        }
      ),
    );
  }
}
