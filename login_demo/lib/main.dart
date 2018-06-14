import 'package:flutter/material.dart';

import 'screens/root_page.dart';
import 'auth/firebase_auth.dart';

void main() {
  runApp( new MyApp() );
}

class MyApp extends StatelessWidget {
  @override
  Widget build( BuildContext context ) {
    return new MaterialApp(
      title: "Firebase Login",
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new RootPage( auth: new Auth() )
    );
  }
}