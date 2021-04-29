import 'package:flutter/material.dart';
import 'package:flutter_login_screen/constants/app_themes.dart';
import 'package:flutter_login_screen/model/user.dart';
import 'package:flutter_login_screen/services/helper.dart';

// final usersRef = FirebaseFirestore.instance.collection('users');

class Profile extends StatefulWidget {
  final User user;
  Profile({this.user});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Future<DocumentSnapshot> getUserInfo() async {
  //   return await usersRef.doc('113847347114787469946').get();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppThemes.lightTheme.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                displayCircleImage(widget.user.profilePictureURL, 125, false),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.user.firstName),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.user.email),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.user.phoneNumber),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.user.userID),
                ),
              ],
            ),
          ),
        ));
  }
}
