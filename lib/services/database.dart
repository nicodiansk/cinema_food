import 'package:cinema_food/modules/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('userData');

  Future updateUserData(String name, String email, int points) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'email': email,
      'points': points,
    });
  }

  //userData form snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      points: snapshot.data['points'],
    );
  }

  Stream<QuerySnapshot> get userD {
    return userCollection.snapshots();
  }

  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
