import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const textInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 14),
  filled: true,
  fillColor: Colors.white,
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: Colors.purple, width: 2)),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: Colors.grey, width: 2)),
);

var cardBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(20)),
    boxShadow: [BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10)]);

const kSpacingUnit = 10;
const kTextColor = Colors.black;
const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF373737);
const kLightPrimaryColor = Colors.lightBlueAccent;
const kLightSecondaryColor = Colors.purple;
const kAccentColor = Color(0xFFFFC107);

final kTitleTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 2.5),
  fontWeight: FontWeight.w600,
);

final kCaptionTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.3),
  fontWeight: FontWeight.w100,
);

final kButtonTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
  fontWeight: FontWeight.w400,
  color: kDarkPrimaryColor,
);

final kMenuButtonTextStyle = TextStyle(
    fontSize: ScreenUtil().setSp(20),
    fontWeight: FontWeight.w400,
    color: kLightSecondaryColor);

final kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'SFProText',
  primaryColor: kDarkPrimaryColor,
  canvasColor: kDarkPrimaryColor,
  backgroundColor: kDarkSecondaryColor,
  accentColor: kAccentColor,
  iconTheme: ThemeData.dark().iconTheme.copyWith(
        color: kLightSecondaryColor,
      ),
  textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kLightSecondaryColor,
        displayColor: kLightSecondaryColor,
      ),
);

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'SFProText',
  primaryColor: kLightPrimaryColor,
  canvasColor: Colors.white,
  backgroundColor: kLightSecondaryColor,
  accentColor: kAccentColor,
  iconTheme: ThemeData.light().iconTheme.copyWith(
        color: kDarkSecondaryColor,
      ),
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kDarkSecondaryColor,
        displayColor: kDarkSecondaryColor,
      ),
);
