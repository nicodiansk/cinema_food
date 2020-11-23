import 'dart:io';

import 'package:cinema_food/modules/user.dart';
import 'package:cinema_food/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://cinema-food.appspot.com');

  AuthService _auth = AuthService();
  Future<String> uploadFile(File file) async {
    FirebaseUser fUser = await FirebaseAuth.instance.currentUser();
    User user = _auth.userFromFirebaseUser(fUser);
    var storageRef = storage.ref().child('user/profile/${user.uid}');
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask.onComplete;
    String downloadUrl = await completedTask.ref.getDownloadURL();
    return downloadUrl;
  }
}
