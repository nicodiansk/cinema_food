import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String avatarUrlIntoAvatar;
  final Function onTap;
  Avatar({this.avatarUrlIntoAvatar, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Center(
          child: avatarUrlIntoAvatar == null
              ? CircleAvatar(
                  foregroundColor: Colors.purple,
                  radius: 50,
                  child: Icon(Icons.camera),
                )
              : CircleAvatar(
                  foregroundColor: Colors.purple,
                  radius: 50,
                  backgroundImage: NetworkImage(avatarUrlIntoAvatar),
                  /*child: ClipOval(
                    child: Image.file(
                      avatarUrl,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                  ),*/
                ),
        ));
  }
}

class FoodAvatar extends StatelessWidget {
  final String imageUrl;
  FoodAvatar(this.imageUrl);
  bool isUrl() {
    return Uri.parse(imageUrl).isAbsolute;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isUrl() == false
          ? CircularProgressIndicator()
          : CircleAvatar(
              foregroundColor: Colors.purple,
              radius: 100,
              backgroundImage: NetworkImage(imageUrl),
            ),
    );
  }
}

class CartFoodAvatar extends StatelessWidget {
  final String imageUrl;
  CartFoodAvatar(this.imageUrl);
  bool isUrl() {
    return Uri.parse(imageUrl).isAbsolute;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isUrl() == false
          ? CircularProgressIndicator()
          : CircleAvatar(
              foregroundColor: Colors.purple,
              radius: 50,
              backgroundImage: NetworkImage(imageUrl),
            ),
    );
  }
}
