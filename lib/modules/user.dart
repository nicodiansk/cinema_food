import 'dart:io';

import 'package:cinema_food/services/auth.dart';
import 'package:cinema_food/services/database.dart';
import 'package:cinema_food/services/storage.dart';

class User {
  final String uid;
  final String email;
  String name;
  String avatarUrl;
  int points;
  User({this.uid, this.email, this.name, this.points, this.avatarUrl});
}

class UserData {
  final String uid;
  final String name;
  final int points;
  String avatarUrl;
  User _currentUser;
  AuthService _auth = AuthService();
  Storage _storage = Storage();
  Future init;
  UserData({this.uid, this.name, this.points, this.avatarUrl}) {
    init = initUser();
  }

  Future<User> initUser() async {
    _currentUser = await _auth.getCurrentUser();
    return _currentUser;
  }

  Future<void> signInWithEmailAndPassword(
      {String email, String password}) async {
    try {
      _currentUser = await _auth.signInWithEmailAndPassword(email, password);
      _currentUser.avatarUrl = await getDownloadUrl();
    } on Exception catch (e) {
      return null;
    }
  }

  Future<void> uploadProfilePicture(File image) async {
    _currentUser.avatarUrl = await _storage.uploadProfilePicture(image);
    await DatabaseService(uid: _currentUser.uid)
        .updateAvatarUrl(_currentUser.avatarUrl);
  }

  Future<String> getDownloadUrl() async {
    return await _storage.getUserProfileImageDownloadUrl(_currentUser.uid);
  }
}
