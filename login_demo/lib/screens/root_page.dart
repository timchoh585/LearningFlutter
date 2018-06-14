import 'package:flutter/material.dart';

import 'login_page.dart';
import 'home_page.dart';
import '../auth/firebase_auth.dart';

class RootPage extends StatefulWidget {
  RootPage({ this.auth });
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  initState() {
    super.initState();

    widget.auth.currentUser().then(( userId ) {
      setState(() {
              _authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
            });
    });
  }
  
  @override
  Widget build( BuildContext context ) {
    switch( _authStatus ) {
      case AuthStatus.notSignedIn:
        return new LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return new HomePage(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
  }

  void _signedIn() {
    setState(() {
          _authStatus = AuthStatus.signedIn;
        });
  }

  void _signedOut() {
    setState(() {
          _authStatus = AuthStatus.notSignedIn;
        });
  }
}