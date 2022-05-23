import 'package:flutter/material.dart';
import 'package:hot_breverage/screens/authenticate/register.dart';
import 'package:hot_breverage/screens/authenticate/sing_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showsignIn = true;

  toggleView() {
    setState(() => showsignIn = !showsignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showsignIn == true) {
      return SingIn(tView: toggleView);
    } else {
      return Register(tView: toggleView);
    }
  }
}
