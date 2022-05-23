import 'package:flutter/material.dart';
import 'package:hot_breverage/services/auth.dart';
import 'package:hot_breverage/shared/decoration.dart';
import 'package:hot_breverage/shared/loading.dart';

class SingIn extends StatefulWidget {
  final Function tView;
  SingIn({required this.tView});

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final AuthService _authServices = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              title: const Text("Sing In to Hot Beverage"),
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(141, 110, 99, 1),
              elevation: 0.0,
              actions: <Widget>[
                TextButton.icon(
                  icon: const Icon(Icons.person),
                  label: const Text('Register'),
                  onPressed: () {
                    widget.tView();
                  },
                ),
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) {
                        if (val != null && val.isEmpty) {
                          return 'Enter an email';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'password'),
                      validator: (val) {
                        if (val != null && val.length < 6) {
                          return 'Enter a password 6+ chars long';
                        }
                      },
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      child: const Text('Sign in'),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _authServices
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error =
                                  'Could not sign in with those credentials';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
