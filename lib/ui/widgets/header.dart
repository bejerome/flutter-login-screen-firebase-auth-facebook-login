import 'dart:io';

import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    return GFListTile(
      title: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              icon,
              color: Theme.of(context).appBarTheme.color,
            ),
            SizedBox(
              width: 30.00,
            ),
            GestureDetector(
              onTap: () {
                menuTextCallBack();
              },
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 30.00,
                    fontFamily: "Signatra",
                    color: Colors.black),
              ),
            )
          ],
        ),
      ),
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

  Future<void> setProfileImage() async {}

  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Container(
      color: AppThemes.lightTheme.backgroundColor,
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
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
          isAppTitle ? user.firstName : "",
          style: TextStyle(
              fontSize: isAppTitle ? 18 : 30,
              fontFamily: "Signatra",
              color: Colors.black),
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
            return GestureDetector(
              onVerticalDragEnd: (details) {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: GFAvatar(
                            backgroundColor:
                                AppThemes.lightTheme.backgroundColor,
                            backgroundImage:
                                NetworkImage("${user.profilePictureURL}"),
                            shape: GFAvatarShape.circle),
                      ),
                      Positioned(
                          bottom: 0,
                          left: MediaQuery.of(context).size.width * 0.3,
                          child: GFAvatar(
                            backgroundColor: Colors.white,
                            child: GestureDetector(
                                onTap: () {}, child: Icon(Icons.edit)),
                            size: GFSize.SMALL,
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

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [Text(data['email'])],
                    // ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: GFButtonBadge(
                            type: GFButtonType.outline2x,
                            icon: Icon(Icons.email),
                            color: Colors.transparent,
                            onPressed: () {},
                            text: 'Email',
                            textColor:
                                Theme.of(context).bottomAppBarTheme.color,
                          ),
                        ),
                        Container(
                          child: GFButtonBadge(
                            type: GFButtonType.outline2x,
                            icon: Icon(Icons.email),
                            color: Colors.transparent,
                            onPressed: () {},
                            text: 'Posts',
                            textColor: Colors.black,
                          ),
                        ),
                        Container(
                          child: GFButtonBadge(
                            type: GFButtonType.outline2x,
                            icon: Icon(Icons.post_add_sharp),
                            color: Colors.transparent,
                            onPressed: () {},
                            text: 'Comments',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
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
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          size: 50,
                        ),
                      ],
                    )
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
