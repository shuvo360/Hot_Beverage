import 'package:flutter/material.dart';
import 'package:hot_breverage/models/user.dart';
import 'package:hot_breverage/screens/authenticate/authenticate.dart';
import 'package:hot_breverage/screens/home/home.dart';
import 'package:provider/provider.dart';

class wrapper extends StatelessWidget {
  const wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<Users?>(context);

    //return either authentication or home page
    if (customer == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
