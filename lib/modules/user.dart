class User {
  final String uid;
  final String email;
  String name;
  User({this.uid, this.email});
}

class UserData {
  final String uid;
  final String name;
  final int points;

  UserData({this.uid, this.name, this.points});
}
