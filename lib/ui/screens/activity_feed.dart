import 'package:flutter/material.dart';
import 'package:flutter_login_screen/constants/app_themes.dart';
import 'package:flutter_login_screen/ui/widgets/all_users_list.dart';

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
    return Container();
  }
}
