class User {
  final String uid;
  final String email;
  String name;
  String avatarUrl;
  User({this.uid, this.email});
}

class UserData {
  final String uid;
  final String name;
  final int points;
  String avatarUrl;

  UserData({this.uid, this.name, this.points, String avatarUrl});
}
