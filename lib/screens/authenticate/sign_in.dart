import 'package:cinema_food/services/auth.dart';
import 'package:cinema_food/shared/constants.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 110, 0, 0),
                    child: RichText(
                        text: TextSpan(
                            text: 'Cinema\nFood',
                            style: TextStyle(
                                fontSize: 70,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                          TextSpan(
                              text: '.',
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold))
                        ])),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(20, 35, 20, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'EMAIL', prefixIcon: Icon(Icons.email)),
                        validator: (value) =>
                            value.isEmpty ? 'Inserire una email valida' : null,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'PASSWORD', prefixIcon: Icon(Icons.lock)),
                        validator: (value) => value.length < 6
                            ? 'Inserire una password lunga almeno 6 caratteri'
                            : null,
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ButtonTheme(
                          minWidth: 150,
                          child: RaisedButton.icon(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'Accesso non riuscito. Riprovare';
                                  });
                                }
                              }
                            },
                            icon: Icon(
                              Icons.login,
                              color: Colors.white,
                            ),
                            splashColor: Colors.lightBlueAccent,
                            color: Colors.purple[300],
                            label: Text(
                              'Accedi',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: ButtonTheme(
                          minWidth: 150,
                          child: RaisedButton.icon(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {
                              widget.toggleView();
                            },
                            icon: Icon(
                              Icons.person_add,
                              color: Colors.white,
                            ),
                            splashColor: Colors.purple[300],
                            color: Colors.lightBlueAccent,
                            label: Text(
                              'Registrati ora!',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )
                    ],
                  ),
                ))
          ],
        ));
  }
}

/*appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          elevation: 0,
          title: Text('Accedi a Cinema Food!'),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  widget.toggleView();
                },
                icon: Icon(Icons.person),
                label: Text(
                  'Registrati',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
          ],
        ),*/
/*body: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                RichText(
                    text: TextSpan(
                        text: 'Cinema\nFood',
                        style: TextStyle(
                            fontSize: 70,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                      TextSpan(
                          text: '.',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 80,
                              fontWeight: FontWeight.bold))
                    ])),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: 'EMAIL', prefixIcon: Icon(Icons.email)),
                  validator: (value) =>
                      value.isEmpty ? 'Inserire una email valida' : null,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: 'PASSWORD', prefixIcon: Icon(Icons.lock)),
                  validator: (value) => value.length < 6
                      ? 'Inserire una password lunga almeno 6 caratteri'
                      : null,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          error = 'Accesso non riuscito. Riprovare';
                        });
                      }
                    }
                  },
                  color: Colors.orange,
                  child: Text(
                    'Accedi',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                )
              ],
            ),
          )),*/
