import 'package:flutter/material.dart';
import 'package:flutter_login_screen/constants/app_themes.dart';
import 'package:flutter_login_screen/services/authenticate.dart';
import 'package:flutter_login_screen/ui/widgets/all_users_list.dart';
import 'package:flutter_login_screen/ui/widgets/getwidget.dart';
import 'package:flutter_login_screen/ui/widgets/header.dart';

class ActivityFeed extends StatefulWidget {
  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppThemes.lightTheme.backgroundColor,
        body: ActivityFeedItem());
  }
}

class ActivityFeedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          // Text(
          //   'Activity Feed Item',
          //   style: TextStyle(
          //       fontSize: 30, fontFamily: "Signatra", color: Colors.red),
          // ),
          GetUsersList(),
      // GFListTile(
      //     avatar: GFAvatar(),
      //     titleText: 'Title',
      //     subtitleText:
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing',
      //     icon: Icon(Icons.favorite)),
      // GFListTile(
      //     avatar: GFAvatar(
      //         // backgroundImage: NetworkImage("${user.}"),
      //         ),
      //     titleText: 'Title',
      //     subtitleText:
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing',
      //     icon: Icon(Icons.favorite)),
    );
  }
}
