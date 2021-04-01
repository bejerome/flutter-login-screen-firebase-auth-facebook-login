import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_screen/model/campsites.dart';
import 'package:flutter_login_screen/ui/widgets/all_users_list.dart';
import 'package:flutter_login_screen/ui/widgets/custom_site_card.dart';

import 'getwidget.dart';

final CollectionReference campsitesRef =
    FirebaseFirestore.instance.collection('campsites');
final currentUser = FirebaseAuth.instance.currentUser;
final DateTime timestamp = DateTime.now();

class CampSiteList extends StatefulWidget {
  CampSiteList({
    Key key,
  }) : super(key: key);
  _CampSiteState createState() => _CampSiteState();
}

class _CampSiteState extends State<CampSiteList> {
  Stream<dynamic> campsites;
  @override
  void initState() {
    campsites = campsitesRef.get().then((doc) => doc).asStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: campsites,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GFLoader(
              type: GFLoaderType.circle,
            );
          }

          return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
            Campsite campsite = Campsite.fromJson(document.data());
            return CustomSiteCard(
              title: campsite.siteName,
              subTitle: "Site # ${campsite.number}",
              imagePath: campsite.imageURL,
              ratings: campsite.rating,
            );
          }).toList());
        },
      ),
    );
  }
}
