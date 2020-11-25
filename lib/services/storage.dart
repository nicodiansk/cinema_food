import 'dart:io';

import 'package:cinema_food/modules/user.dart';
import 'package:cinema_food/services/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Storage {
  AuthService _auth = AuthService();
  FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://cinema-food.appspot.com/');

  Future<String> uploadProfilePicture(File _image) async {
    User user = await _auth.getCurrentUser();
    /*print(user.uid);
    print(user.email);
    print(user.name);
    print(user.avatarUrl);*/

    var firebaseStorageRef =
        FirebaseStorage.instance.ref().child('user/profile/${user?.uid}');
    String fileName = basename(_image.path);

    var uploadTask = firebaseStorageRef.putFile(_image);
    var completedTask = await uploadTask.onComplete;
    String downloadUrl = await completedTask.ref.getDownloadURL();
    print('Download URL: ' + downloadUrl);
    return downloadUrl;
  }

  Future<String> getUserProfileImageDownloadUrl(String uid) async {
    var storageRef = _storage.ref().child("user/profile/$uid");
    return await storageRef.getDownloadURL();
  }
}
