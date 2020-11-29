import 'package:cinema_food/shared/constants.dart';
import 'package:flutter/material.dart';

class CategoryTitle extends StatelessWidget {
  final String title;
  final bool active;
  const CategoryTitle({Key key, this.active = false, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 30),
      child: Text(
        title,
        style: TextStyle(
            color: active ? kLightSecondaryColor : kTextColor.withOpacity(0.4),
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
