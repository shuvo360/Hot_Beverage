import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hot_breverage/models/brew.dart';
import 'package:hot_breverage/models/user.dart';

class databaseService {
  final String? uid;
  databaseService({this.uid});
  //collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('beverages');

  Future updateUserdata(String sugers, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugers': sugers,
      'name': name,
      'strength': strength,
    });
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.get('name') ?? '',
        strength: doc.get('strength') ?? 0,
        sugars: doc.get('sugers') ?? '0',
      );
    }).toList();
  }

  //userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name') ?? '',
      sugars: snapshot.get('sugers') ?? '0',
      strength: snapshot.get('strength') ?? 0,
    );
  }

  //get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc strem
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
