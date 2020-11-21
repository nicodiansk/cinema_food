import 'package:cinema_food/modules/user.dart';
import 'package:cinema_food/services/database.dart';
import 'package:cinema_food/shared/constants.dart';
import 'package:cinema_food/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserSettings extends StatelessWidget {
  bool _hasPic = true;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        allowFontScaling: true, designSize: Size(414, 896));
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            var profileInfo = Expanded(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 30),
                    child: Stack(children: [
                      CircleAvatar(
                          radius: 50,
                          backgroundImage: _hasPic
                              ? AssetImage('assets/images/ironman.jpg')
                              : null),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              shape: BoxShape.circle),
                          child: Icon(
                            LineAwesomeIcons.pen,
                            color: kLightSecondaryColor,
                            size: ScreenUtil().setSp(15),
                          ),
                        ),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${userData.name}',
                    style: kTitleTextStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Punti: ${userData.points}',
                    style: kTitleTextStyle,
                  )
                ],
              ),
            );
            return Scaffold(
              body: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 30,
                      ),
                      Icon(
                        LineAwesomeIcons.info_circle,
                        size: ScreenUtil().setSp(30),
                        color: Colors.black,
                      ),
                      profileInfo,
                      Icon(
                        LineAwesomeIcons.moon,
                        size: ScreenUtil().setSp(30),
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
