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
                    '${userData.name ?? null}',
                    style: kTitleTextStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Punti: ${userData.points ?? null}',
                    style: kTitleTextStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            );
            var header = Row(
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
            );

            return Scaffold(
              body: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  header,
                  Expanded(
                      child: ListView(
                    children: <Widget>[
                      ProfileListItem(
                        icon: Icon(
                          Icons.privacy_tip,
                          color: Colors.white,
                        ),
                        text: 'Privacy',
                        hasNavigation: true,
                      ),
                      ProfileListItem(
                        icon: Icon(Icons.shopping_bag, color: Colors.white),
                        text: 'I miei ordini',
                        hasNavigation: true,
                      ),
                      ProfileListItem(
                        icon: Icon(Icons.help, color: Colors.white),
                        text: 'Aiuto e supporto',
                        hasNavigation: true,
                      ),
                      ProfileListItem(
                        icon: Icon(Icons.settings, color: Colors.white),
                        text: 'Impostazioni',
                        hasNavigation: true,
                      ),
                      ProfileListItem(
                        icon: Icon(Icons.person_add, color: Colors.white),
                        text: 'Invita un Amico!',
                        hasNavigation: true,
                      ),
                    ],
                  ))
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

class ProfileListItem extends StatefulWidget {
  final Icon icon;
  final text;
  final bool hasNavigation;
  const ProfileListItem({
    this.icon,
    this.text,
    this.hasNavigation,
    Key key,
  }) : super(key: key);

  @override
  _ProfileListItemState createState() => _ProfileListItemState();
}

class _ProfileListItemState extends State<ProfileListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(35, 5, 35, 20),
      child: RaisedButton(
        splashColor: Colors.lightBlueAccent,
        onPressed: () {},
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Ink(
          padding: EdgeInsets.all(8),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.05, 0.6],
                  colors: <Color>[Colors.purple, Colors.lightBlueAccent])),
          child: Container(
            constraints: const BoxConstraints(minWidth: 88, minHeight: 36),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                this.widget.icon,
                SizedBox(
                  width: 25,
                ),
                Text(
                  this.widget.text,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_right_sharp,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*return Container(
      height: 55,
      margin: EdgeInsets.symmetric(
        horizontal: 40,
      ).copyWith(
        bottom: 20,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.purple[300],
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.widget.icon,
            size: 25,
            color: Colors.white,
          ),
          SizedBox(width: 15),
          Text(
            this.widget.text,
            style: kTitleTextStyle.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          if (this.widget.hasNavigation)
            Icon(
              LineAwesomeIcons.angle_right,
              size: 25,
              color: Colors.white,
            ),
        ],
      ),
    );*/

/*RaisedButton.icon(
        splashColor: Colors.lightBlueAccent,
        padding: EdgeInsets.all(13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Colors.lightBlue,
        onPressed: () {},
        icon: this.widget.icon,
        label: Text(
          this.widget.text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),*/
