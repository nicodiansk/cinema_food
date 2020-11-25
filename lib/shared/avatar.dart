import 'dart:io';

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
