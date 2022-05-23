import 'package:flutter/material.dart';
import 'package:hot_breverage/models/user.dart';
import 'package:hot_breverage/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:hot_breverage/shared/decoration.dart';
import 'package:hot_breverage/services/database.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> suggers = ['0', '1', '2', '3', '4'];
//import 'package:firebase_auth/firebase_auth.dart';
  //form value
  var _currentName;
  var _currentSuger;
  var _currentStrength;
  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<Users?>(context);
    return StreamBuilder<UserData>(
        stream: databaseService(uid: customer?.uid).userData,
        builder: (context, snapshot) {
          UserData? userdata = snapshot.data;
          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'updat your brew settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userdata?.name,
                    decoration: textInputDecoration.copyWith(hintText: 'name'),
                    validator: (val) {
                      if (val != null && val.isEmpty) {
                        return 'please enter a name';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  const SizedBox(height: 20.0),
                  //dropdown
                  DropdownButtonFormField<String>(
                    value: _currentSuger ?? userdata?.sugars,
                    decoration: textInputDecoration.copyWith(hintText: 'suger'),
                    items: suggers.map((suger) {
                      return DropdownMenuItem(
                        value: suger,
                        child: Text('$suger sugers'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSuger = val),
                  ),
                  //slider
                  Slider(
                    value: (_currentStrength ?? userdata?.strength).toDouble(),
                    activeColor:
                        Colors.brown[_currentStrength ?? userdata?.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userdata?.strength],
                    min: 100,
                    max: 900,
                    divisions: 16,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await databaseService(uid: customer?.uid)
                              .updateUserdata(
                                  _currentSuger ?? userdata?.sugars,
                                  _currentName ?? userdata?.name,
                                  _currentStrength ?? userdata?.strength);
                          Navigator.pop(context);
                        }
                      }),
                ],
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
