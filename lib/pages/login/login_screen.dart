
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librivox_audiobook_player/pages/login/bloc/login_event.dart';
import 'package:librivox_audiobook_player/resources/blocs/authentication/authentication%20state.dart';
import 'package:librivox_audiobook_player/resources/blocs/authentication/authentication_bloc.dart';
import 'package:librivox_audiobook_player/resources/services/services.dart';

import 'bloc/login_bloc.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            final authBloc = BlocProvider.of<AuthenticationBloc>(context);
            if (state is AuthenticationNotAuthenticated) {
              return _AuthForm();
            }
            if (state is AuthenticationFailure) {
              // Error message
              return Center(
                child: Text("Error occurred: " + state.message)
              );
            }
            return Center(
              child: CircularProgressIndicator(strokeWidth: 2)
            );
          }
        )
      )
    );
  }

}

class _AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final authService = RepositoryProvider.of<AuthenticationService>(context);

    return Container(
      alignment: Alignment.center,
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(authBloc, authService),
          child: _SignInForm()
        ),
    );
  }

}

class _SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    _onLoginButtonPressed() {
   //   if (_key.currentState.validate()) {
        _loginBloc.add(LoginWithEmailButtonPressed(
            email: _emailController.text,
            password: _passwordController.text
        ));
    //  }
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          _showError(state.error);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email address',
                      filled: true,
                      isDense: true,
                    ),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    /*validator: (value) {
                      if (value == null) {
                        return "Email required.";
                      }
                      return null;
                    },*/
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      filled: true,
                      isDense: true
                    ),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null) {
                        return "Password required.";
                      }
                      return null;
                    }
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    // color: Theme.of(context).primaryColor,
                    // textColor: Colors.white,
                    // padding: const EdgeInsets.all(16),
                    // shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                    child: Text("Log in"),
                    onPressed: state is LoginLoading ? () {} : _onLoginButtonPressed
                  )
                ]
              )
            )
          );
        }
      )
    );
  }

  void _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Theme.of(context).errorColor
      )
    );
  }
}
