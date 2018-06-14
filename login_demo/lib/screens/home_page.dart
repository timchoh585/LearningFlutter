import 'package:flutter/material.dart';

import '../auth/firebase_auth.dart';

class HomePage extends StatelessWidget {

  HomePage({ this.auth, this.onSignedOut });
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  
  @override
  Widget build( BuildContext context ) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text( "Welcome" ),
        actions: <Widget>[
          new FlatButton(
            child: new Text(
              "Log Out",
              style: new TextStyle(
                fontSize: 17.0,
                color: Colors.white
              ),
            ),
            onPressed: _signOut,
          ),
        ],
      ),
      body: new Container(
        child: new Center(
          child: new Text(
            "Welcome",
            style: new TextStyle( fontSize: 20.0 ),
          )
        ),
      ),
    );
  }

  void _signOut() async {
    try{
      await auth.signOut();
      onSignedOut();
    } catch( e ) {
      print( e );
    }
  }
}