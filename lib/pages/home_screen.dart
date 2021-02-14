
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librivox_audiobook_player/resources/blocs/authentication/authentication_bloc.dart';
import 'package:librivox_audiobook_player/resources/blocs/authentication/authentication_event.dart';
import 'package:librivox_audiobook_player/resources/models/models.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Hi welcome',
                style: TextStyle(fontSize: 24)
              ),
              const SizedBox(height:12),
              ElevatedButton(
                child: Text("Logout"),
                onPressed: () {
                  authBloc.add(UserLoggedOut());
                }
              )
            ]
          )
        )
      )
    );
  }



}