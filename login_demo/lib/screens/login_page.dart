import 'package:flutter/material.dart';

import '../auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({ this.auth, this.onSignedIn });

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage> {

  final formKey = new GlobalKey< FormState >();

  String _email;
  String _password;

  FormType _formType = FormType.login;

  @override
  Widget build( BuildContext context ) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text( "Login Demo" ),
      ),
      body: new Container(
        padding: EdgeInsets.all( 16.0 ),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInputs() + buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        decoration: new InputDecoration(
          labelText: "Email",
        ),
        validator: ( value ) => value.isEmpty ? "Email can\'t be empty" : null,
        onSaved: ( value ) => _email = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(
          labelText: "Password",
        ),
        obscureText: true,
        validator: ( value ) => value.isEmpty ? "Password can\'t be empty" : null,
        onSaved: ( value ) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if( _formType == FormType.login ) {
      return [
        new RaisedButton(
          child: new Text(
            "Log In",
            style: new TextStyle( fontSize: 20.0 ),
          ),
          onPressed: _validateAndSubmit,
        ),
        new FlatButton(
          child: new Text(
            "Create an Account",
            style: new TextStyle( fontSize: 16.0 ),
          ),
          onPressed: _switchForm,
        ),
      ];
    } else {
      return [
        new RaisedButton(
          child: new Text(
            "Create an Account",
            style: new TextStyle( fontSize: 20.0 ),
          ),
          onPressed: _validateAndSubmit,
        ),
        new FlatButton(
          child: new Text(
            "Have an Account? Log In",
            style: new TextStyle( fontSize: 16.0 ),
          ),
          onPressed: _switchForm,
        ),
      ];
    }
  }

  bool _validateAndSave() {
    final form = formKey.currentState;

    if( form.validate() ) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void _validateAndSubmit() async {
    if( _validateAndSave() ) {
      try {
        switch( _formType ) {
          case FormType.login:
            String userId = await widget.auth.signInWithEmailAndPassword( _email, _password );
            print( "Signed In: $userId" );
            break;
          case FormType.register:
            String userId = await widget.auth.createUserWithEmailAndPassword( _email, _password );
            print( "Created Account: $userId" );
            break;
        }
        widget.onSignedIn();
      } catch( e ) {
        print( "Error: $e" );
      }
    }
  }

  void _switchForm() {
    formKey.currentState.reset();
    switch( _formType ) {
      case FormType.login:
        setState(() {
                _formType = FormType.register;
              });
        break;
      case FormType.register:
        setState(() {
                _formType = FormType.login;
              });
        break;
    }
  }
}