import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference userData =
      Firestore.instance.collection('userData');

  Future updateUserData(String name, String email) async {
    return await userData.document(uid).setData({
      'nome': name,
      'email': email,
    });
  }

  Stream<QuerySnapshot> get userD {
    return userData.snapshots();
  }
}
