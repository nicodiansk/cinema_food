import 'package:cinema_food/modules/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('userData');

  Future setUserData(
      {String name, String email, int points, String avatarURL}) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'email': email,
      'points': points,
      'url': avatarURL,
    });
  }

  Future updateUserData(
      {String name, String email, int points, String avatarURL}) async {
    return await userCollection.document(uid).updateData({
      'name': name,
      'email': email,
      'points': points,
      'url': avatarURL,
    });
  }

  Future updateAvatarUrl(String avatarURL) async {
    return await userCollection.document(uid).updateData({
      'url': avatarURL,
    });
  }

  //userData form snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        points: snapshot.data['points'],
        avatarUrl: snapshot.data['url']);
  }

  User _userFromSnapshot(DocumentSnapshot snapshot) {
    return User(
        uid: uid,
        name: snapshot.data['name'],
        email: snapshot.data['email'],
        points: snapshot.data['points'],
        avatarUrl: snapshot.data['url']);
  }

  Stream<User> getUser() {
    return userCollection.document(uid).snapshots().map(_userFromSnapshot);
  }

  Stream<QuerySnapshot> get userD {
    return userCollection.snapshots();
  }

  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
