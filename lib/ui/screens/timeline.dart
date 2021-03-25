import 'package:flutter/material.dart';
import 'package:flutter_login_screen/constants/app_themes.dart';
import 'package:flutter_login_screen/ui/widgets/custom_site_card.dart';

// FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  @override
  Widget build(context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppThemes.lightTheme.backgroundColor,
        body: SingleChildScrollView(
            child: Center(
          child: Container(
            width: width > 414 ? width * 0.5 : width,
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
          ),
        )));
  }
}
