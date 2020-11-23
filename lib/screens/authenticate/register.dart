import 'package:cinema_food/services/auth.dart';
import 'package:cinema_food/shared/constants.dart';
import 'package:cinema_food/shared/loading.dart';
import 'package:cinema_food/shared/screen_title.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String nome = '';
  String email = '';
  String password = '';
  String _passwordConfirm = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 50, 0, 0),
                    child: ScreenTitle(
                      title: 'Sign\nUp',
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 22, 20, 0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'NOME COMPLETO',
                                prefixIcon: Icon(Icons.person)),
                            validator: (value) =>
                                value.isEmpty ? 'Inserire un nome' : null,
                            onChanged: (value) {
                              setState(() {
                                nome = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'EMAIL',
                                prefixIcon: Icon(Icons.email)),
                            validator: (value) => value.isEmpty
                                ? 'Inserire una email valida'
                                : null,
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
                                hintText: 'PASSWORD',
                                prefixIcon: Icon(Icons.lock)),
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
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'RIPETI PASSWORD',
                                prefixIcon: Icon(Icons.lock)),
                            validator: (value) => password != value
                                ? 'La password non corrisponde!'
                                : null,
                            obscureText: true,
                            onChanged: (value) {
                              setState(() {
                                _passwordConfirm = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: ButtonTheme(
                              minWidth: 180,
                              child: RaisedButton.icon(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () async {
                                  dynamic result;
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    if (password == _passwordConfirm) {
                                      result = await _auth
                                          .registerWithEmailAndPassword(
                                              email, password, nome);
                                    }
                                    if (result == null &&
                                        password == _passwordConfirm) {
                                      setState(() {
                                        loading = false;
                                        error = 'Inserire una email valida!';
                                      });
                                    } else {
                                      loading = false;
                                      error = 'La password non corrisponde!';
                                    }
                                  }
                                },
                                icon: Icon(
                                  Icons.person_add,
                                  color: Colors.white,
                                ),
                                splashColor: Colors.lightBlueAccent,
                                color: Colors.purple[300],
                                label: Text(
                                  'Registrati',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: ButtonTheme(
                              minWidth: 180,
                              child: RaisedButton.icon(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  widget.toggleView();
                                },
                                icon: Icon(
                                  Icons.login,
                                  color: Colors.white,
                                ),
                                splashColor: Colors.purple[300],
                                color: Colors.lightBlueAccent,
                                label: Text(
                                  'Ho già un account!',
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
                          Center(
                            child: Text(
                              error,
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ));
  }
}

/*return Scaffold(
      backgroundColor: Colors.blue[100],
      
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Email', prefixIcon: Icon(Icons.email)),
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
                      hintText: 'Password', prefixIcon: Icon(Icons.lock)),
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
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          error = 'Inserire una email valida';
                        });
                      }
                    }
                  },
                  color: Colors.orange,
                  child: Text(
                    'Registrati',
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
          )),
    );*/
