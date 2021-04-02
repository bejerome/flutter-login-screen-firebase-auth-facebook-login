import 'dart:io';

import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_screen/constants.dart';
import 'package:flutter_login_screen/constants/app_themes.dart';
import 'package:flutter_login_screen/model/user.dart';
import 'package:flutter_login_screen/ui/widgets/getwidget.dart';

class MenuText extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function menuTextCallBack;
  const MenuText({Key key, this.title, this.icon, this.menuTextCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        menuTextCallBack();
      },
      child: Container(
          height: 80.0,
          child: GFCard(
            borderRadius: BorderRadius.circular(10.0),
            elevation: 0,
            padding: EdgeInsets.zero,
            title: GFListTile(
              margin: EdgeInsets.zero,
              color: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    color: Color(COLOR_PRIMARY),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(title)
                ],
              ),
              icon: Icon(
                Icons.keyboard_arrow_right,
                size: 30,
              ),
            ),
          )),
    );
  }
}

File image;

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool isAppTitle;
  final Function signOutCallBack;
  final bool isSearchBar;
  final User user;

  const CustomHeader(
      {Key key,
      this.height = 90,
      this.isAppTitle = true,
      this.isSearchBar = false,
      this.signOutCallBack,
      this.user})
      : super(key: key);

  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    TextEditingController searchController = TextEditingController();
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: GFAppBar(
        searchController: searchController,
        searchHintStyle: TextStyle(color: Colors.black, fontSize: 18),
        searchBar: isSearchBar,
        searchBarColorTheme: Colors.red,
        searchTextStyle: TextStyle(color: Colors.black),
        primary: true,
        elevation: 0.0,
        titleSpacing: 50,
        title: Text(
          isAppTitle ? user.fullName() : "",
          style: TextStyle(
            fontSize: isAppTitle ? 18 : 30,
            fontFamily: "Montserrat",
            color: Colors.black,
          ),
        ),
        backgroundColor: AppThemes.lightTheme.backgroundColor,
        leading: OpenContainer(
          closedElevation: 1.0,
          openShape: RoundedRectangleBorder(side: BorderSide.none),
          closedShape: CircleBorder(side: BorderSide.none),
          openColor: AppThemes.lightTheme.backgroundColor,
          transitionType: ContainerTransitionType.fadeThrough,
          transitionDuration: const Duration(milliseconds: 1000),
          closedBuilder: (context, action) {
            return Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000.0),
                child: CachedNetworkImage(
                  imageUrl: "${user.profilePictureURL}",
                ),
              ),
            );
          },
          openBuilder: (context, action) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(children: [
                      Padding(
                        padding: orientation == Orientation.portrait
                            ? const EdgeInsets.only(top: 100.0)
                            : const EdgeInsets.only(top: 0.0),
                        child: GFAvatar(
                            radius: 70,
                            backgroundColor:
                                AppThemes.lightTheme.backgroundColor,
                            backgroundImage: NetworkImage(
                              "${user.profilePictureURL}",
                            ),
                            size: GFSize.SMALL,
                            shape: GFAvatarShape.circle),
                      ),
                      Positioned(
                          bottom: 0,
                          left: MediaQuery.of(context).size.width * 0.25,
                          child: GFAvatar(
                            backgroundColor: Colors.white,
                            child: GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                )),
                            size: 20,
                          ))
                    ]),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: GFTypography(
                        text: user.email,
                        type: GFTypographyType.typo5,
                        showDivider: false,
                        dividerAlignment: Alignment.center,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomFollowersBadge(
                          currentUser: user,
                        ),
                        CustomFollowingsBadge(
                          currentUser: user,
                        ),
                        Container(
                          child: GFButtonBadge(
                            type: GFButtonType.outline2x,
                            icon: Icon(Icons.post_add_sharp),
                            color: Colors.transparent,
                            onPressed: () {},
                            text: 'Postings',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 0,
                    ),
                    Container(
                      padding: orientation == Orientation.portrait
                          ? EdgeInsets.only(left: 0.0, right: 0.0, bottom: 1)
                          : EdgeInsets.only(
                              left: 100.0, right: 100.0, bottom: 15),
                      child: Column(
                        children: [
                          MenuText(
                            title: "Home",
                            icon: Icons.home,
                            menuTextCallBack: () {
                              Navigator.pop(context);
                            },
                          ),
                          MenuText(
                            title: "Profile",
                            icon: Icons.person,
                            menuTextCallBack: () {
                              print("Profile");
                            },
                          ),
                          MenuText(
                            title: "Settings",
                            icon: Icons.settings,
                            menuTextCallBack: () {
                              print("Settings");
                            },
                          ),
                          MenuText(
                            title: 'Logout',
                            icon: Icons.logout,
                            menuTextCallBack: () {
                              signOutCallBack();
                            },
                          ),
                          Padding(
                            padding: orientation == Orientation.portrait
                                ? EdgeInsets.only(top: 50.0)
                                : EdgeInsets.only(top: 0.0),
                            // change to 0 from landscape, 50 portrait
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 50,
                                    color: Color(COLOR_PRIMARY),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class CustomFollowersBadge extends StatelessWidget {
  final User currentUser;
  const CustomFollowersBadge({Key key, this.currentUser}) : super(key: key);

  Future<QuerySnapshot> checkifFollowing() async {
    var result = await FirebaseFirestore.instance
        .collection("follow")
        .doc(currentUser.userID)
        .collection("userFollowers")
        .get()
        .then((doc) => doc);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final Future<QuerySnapshot> followersRef = checkifFollowing();

    return FutureBuilder<QuerySnapshot>(
        future: followersRef,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: GFButtonBadge(
                type: GFButtonType.transparent,
                icon: GFBadge(
                  child: Text("${snapshot.data.size}"),
                  color: Colors.green,
                ),
                color: Colors.transparent,
                onPressed: () {},
                text: 'Followers',
                textColor: Theme.of(context).bottomAppBarTheme.color,
              ),
            );
          }
          return Text("loading");
        });
  }
}

class CustomFollowingsBadge extends StatelessWidget {
  final User currentUser;
  const CustomFollowingsBadge({Key key, this.currentUser}) : super(key: key);

  Future<QuerySnapshot> checkifFollowing() async {
    var result = await FirebaseFirestore.instance
        .collection("following")
        .doc(currentUser.userID)
        .collection("userFollowing")
        .get()
        .then((doc) => doc);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final Future<QuerySnapshot> followersRef = checkifFollowing();

    return FutureBuilder<QuerySnapshot>(
        future: followersRef,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: GFButtonBadge(
                type: GFButtonType.transparent,
                icon: GFBadge(
                  child: Text("${snapshot.data.size}"),
                  color: Colors.green,
                ),
                color: Colors.transparent,
                onPressed: () {},
                text: 'Following',
                textColor: Theme.of(context).bottomAppBarTheme.color,
              ),
            );
          }
          return Text("loading");
        });
  }
}
