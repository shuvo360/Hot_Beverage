import 'package:flutter/material.dart';
import 'package:hot_breverage/models/user.dart';
import 'package:hot_breverage/screens/wrapper.dart';
import 'package:hot_breverage/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
      initialData: null,
      value: AuthService().users,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const wrapper(),
      ),
    );
  }
}
