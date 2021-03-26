import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_screen/constants/app_themes.dart';
import 'package:flutter_login_screen/ui/widgets/all_users_list.dart';
import 'package:flutter_login_screen/ui/widgets/custom_site_card.dart';
import 'package:flutter_login_screen/ui/widgets/getwidget.dart';

// FirebaseFirestore firestore = FirebaseFirestore.instance;
var orientation;

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  // Set default `_initialized` and `_error` state to false
  bool initialized = false;
  bool error = false;
  // FireStoreDatabase dB = new FireStoreDatabase();
  @override
  void initState() {
    super.initState();
  }

  Widget timelinePortrait() {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Center(
            child: Container(
      width: width,
      child: Column(
        children: [
          CustomSiteCard(
            title: "Harold Parker Forest",
            subTitle: "Site# 45",
            imagePath: "assets/images/campsite1.jpeg",
          ),
          CustomSiteCard(
            title: "Camp Denession",
            subTitle: "Site# 15",
            imagePath: "assets/images/campsite2.jpeg",
          ),
          CustomSiteCard(
            title: "Wompatuck State Park",
            subTitle: "Site# 15",
            imagePath: "assets/images/campsite2.jpeg",
          ),
        ],
      ),
    )));
  }

  Widget landscapePortrait() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: width * 0.3,
          child: Container(
            child: FutureBuilder<QuerySnapshot>(
              future: users.get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                    return GFListTile(
                        avatar: GFAvatar(
                          child: Container(
                              color: Colors.transparent,
                              child: CachedNetworkImage(
                                  imageUrl:
                                      "${document.data()['profilePictureURL']}")),
                        ),
                        titleText: document.data()['firstName'],
                        subtitleText: document.data()['email'],
                        icon: Icon(Icons.favorite));
                  }).toList());
                }
                return Text("loading");
              },
            ),
          ),
        ),
        Container(
          width: width * 0.7,
          child: ListView(
            children: [
              CustomSiteCard(
                title: "Harold Parker Forest",
                subTitle: "Site# 45",
                imagePath: "assets/images/campsite1.jpeg",
              ),
              CustomSiteCard(
                title: "Camp Denession",
                subTitle: "Site# 15",
                imagePath: "assets/images/campsite2.jpeg",
              ),
              CustomSiteCard(
                title: "Wompatuck State Park",
                subTitle: "Site# 15",
                imagePath: "assets/images/campsite2.jpeg",
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(context) {
    orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        backgroundColor: AppThemes.lightTheme.backgroundColor,
        body: orientation == Orientation.portrait
            ? timelinePortrait()
            : landscapePortrait());
  }
}
