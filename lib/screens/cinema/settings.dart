import 'dart:io';
//import 'package:firebase/firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cinema_food/modules/user.dart';
import 'package:cinema_food/services/auth.dart';
import 'package:cinema_food/shared/avatar.dart';
import 'package:cinema_food/services/database.dart';
import 'package:cinema_food/shared/constants.dart';
import 'package:cinema_food/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UserSettings extends StatefulWidget {
  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  final AuthService _auth = AuthService();

  File _image;

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker().getImage(source: ImageSource.gallery);
      setState(() {
        _image = File(image.path);
        print(_image.path);
      });
    }

    Future uploadProfilePicture(BuildContext context, User user) async {
      String fileName = basename(_image.path);
      print(_auth.currentUser);
      var firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('${user?.uid}/ProfilePicture/$fileName');
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      setState(() {
        print('Profile Picture uploaded');
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Profile Picture updated!')));
      });
    }

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
                      Avatar(
                        avatarUrl: _image,
                        onTap: () async {
                          //open gallery and select an image
                          setState(() {
                            getImage();
                          });
                        },
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            color: kAccentColor,
                            icon: Icon(Icons.edit),
                            splashRadius: 12,
                            onPressed: () {
                              setState(() {
                                uploadProfilePicture(context, user);
                              });
                            },
                          )
                          /*Container(
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
                        ),*/
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
                IconButton(
                    splashColor: Colors.lightBlueAccent,
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      Alert(
                        context: context,
                        type: AlertType.warning,
                        title: "LOGOUT",
                        desc:
                            "Stai per disconnetterti dalla sessione attuale. Continuare?",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Indietro",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.purple,
                          ),
                          DialogButton(
                            child: Text(
                              "Disconnettimi",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onPressed: () {
                              _auth.signOut();
                              Navigator.pop(context);
                            },
                            gradient: LinearGradient(colors: [
                              Colors.purple,
                              Colors.lightBlueAccent,
                            ]),
                          )
                        ],
                      ).show();
                    }),
                /*Icon(
                  LineAwesomeIcons.alternate_sign_out,
                  size: ScreenUtil().setSp(30),
                  color: Colors.black,
                ),*/
                profileInfo,
                IconButton(
                    splashColor: Colors.lightBlueAccent,
                    icon: Icon(Icons.nights_stay),
                    onPressed: () {}),
                /*Icon(
                  LineAwesomeIcons.moon,
                  size: ScreenUtil().setSp(30),
                  color: Colors.black,
                ),*/
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
                      ),
                      ProfileListItem(
                        icon: Icon(Icons.shopping_bag, color: Colors.white),
                        text: 'I miei ordini',
                      ),
                      ProfileListItem(
                        icon: Icon(Icons.help, color: Colors.white),
                        text: 'Aiuto e supporto',
                      ),
                      ProfileListItem(
                        icon: Icon(Icons.settings, color: Colors.white),
                        text: 'Impostazioni',
                      ),
                      ProfileListItem(
                        icon: Icon(Icons.person_add, color: Colors.white),
                        text: 'Invita un Amico!',
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

  const ProfileListItem({
    this.icon,
    this.text,
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
