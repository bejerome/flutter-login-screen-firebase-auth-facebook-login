import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_screen/constants/app_themes.dart';
import 'package:flutter_login_screen/main.dart';
import 'package:flutter_login_screen/model/user.dart';
import 'package:flutter_login_screen/services/authenticate.dart';
import 'package:flutter_login_screen/services/helper.dart';
import 'package:flutter_login_screen/ui/auth/authScreen.dart';
import 'package:flutter_login_screen/ui/screens/activity_feed.dart';
import 'package:flutter_login_screen/ui/screens/profile.dart';
import 'package:flutter_login_screen/ui/screens/search.dart';
import 'package:flutter_login_screen/ui/screens/timeline.dart';
import 'package:flutter_login_screen/ui/screens/upload.dart';
import 'package:flutter_login_screen/ui/widgets/header.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({Key key, @required this.user}) : super(key: key);

  @override
  State createState() {
    return _HomeState(user);
  }
}

class _HomeState extends State<HomeScreen> {
  final User user;
  GlobalKey bottomNavigationKey = GlobalKey();
  _HomeState(this.user);
  PageController pageController;
  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    if (pageController.hasClients) {
      pageController.animateToPage(
        pageIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void logout() async {
    user.active = false;
    user.lastOnlineTimestamp = Timestamp.now();
    FireStoreUtils.updateCurrentUser(user);
    await auth.FirebaseAuth.instance.signOut();
    MyAppState.currentUser = null;
    pushAndRemoveUntil(context, AuthScreen(), false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.lightTheme.backgroundColor,
      appBar: CustomHeader(
        user: user,
        isAppTitle: true,
        signOutCallBack: () {
          logout();
        },
      ),
      body: Center(
          child: PageView(
        children: [
          Timeline(),
          ActivityFeed(),
          Search(),
          Profile(
            user: user,
          ),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      )),
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: Colors.red,
        activeIconColor: Colors.white,
        inactiveIconColor: Colors.grey,
        textColor: Colors.red,
        barBackgroundColor: Colors.white,
        tabs: [
          TabData(
              iconData: Icons.home,
              title: "Home",
              onclick: () {
                final FancyBottomNavigationState fState =
                    bottomNavigationKey.currentState;
                fState.setPage(2);
              }),
          TabData(
              iconData: Icons.feedback,
              title: "Activity",
              onclick: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Search()))),
          TabData(iconData: Icons.search, title: "Users"),
          TabData(iconData: Icons.person, title: "Profile"),
        ],
        initialSelection: 0,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          onPageChanged(position);
          onTap(position);
        },
      ),
    );
  }
}
