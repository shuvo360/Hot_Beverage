import 'package:flutter/material.dart';
import 'package:hot_breverage/models/brew.dart';
import 'package:hot_breverage/screens/home/settings_form.dart';
import 'package:hot_breverage/services/auth.dart';
import 'package:hot_breverage/services/database.dart';
import 'package:provider/provider.dart';
import 'package:hot_breverage/screens/home/brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>?>.value(
      value: databaseService().brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Hot Beverage"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            FlatButton.icon(
              icon: const Icon(Icons.person),
              onPressed: () async {
                await _auth.singOut();
              },
              label: const Text('logout'),
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingPanel(),
            ),
          ],
        ),
        // ignore: prefer_const_constructors
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
