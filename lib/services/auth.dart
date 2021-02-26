import 'package:cinema_food/modules/user.dart';
import 'package:cinema_food/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _currentUser;

  //create a User from the custom class User from a Firebase User
  User _userFromFirebaseUser(
      {FirebaseUser user, String name, int startingPoints}) {
    return user != null
        ? User(
            uid: user.uid,
            email: user.email,
            name: name,
            points: startingPoints)
        : null;
  }

  Future<User> getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _currentUser = _userFromFirebaseUser(user: user);
    return _currentUser;
  }

  User get currentUser => _currentUser;

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user: user));
  }

  //sign in anon
  Future signinAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user: user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    FirebaseUser user;
    String errorMessage;

    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
    } catch (e) {
      print('Error');
    }

    /*catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }*/
    if (errorMessage != null) {
      print('errore trovato');
      return null;
    }
    return _userFromFirebaseUser(user: user);
  }

  //register with email and password

  Future registerWithEmailAndPassword(
      String email, String password, String nome) async {
    try {
      int startingPoints = 0;
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      //create a new document in the database
      await DatabaseService(uid: user.uid)
          .setUserData(name: nome, email: email, points: startingPoints);

      return _userFromFirebaseUser(
          user: user, name: nome, startingPoints: startingPoints);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut(); //user down the stream goes back to null
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
