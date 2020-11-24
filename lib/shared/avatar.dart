import 'dart:io';

import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final File avatarUrl;
  final Function onTap;
  Avatar({this.avatarUrl, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Center(
          child: avatarUrl == null
              ? CircleAvatar(
                  foregroundColor: Colors.purple,
                  radius: 50,
                  child: Icon(Icons.camera),
                )
              : CircleAvatar(
                  foregroundColor: Colors.purple,
                  radius: 50,
                  child: ClipOval(
                    child: Image.file(
                      avatarUrl,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
        ));
  }
}
