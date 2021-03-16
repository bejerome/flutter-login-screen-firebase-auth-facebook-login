import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_screen/services/authenticate.dart';

import 'getwidget.dart';

class GetUsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<QuerySnapshot>(
      future: users.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
            return GFListTile(
                avatar: GFAvatar(
                  child: Container(
                      color: Colors.transparent,
                      child: CachedNetworkImage(
                          imageUrl: "${document.data()['profilePictureURL']}")),
                ),
                titleText: document.data()['firstName'],
                subtitleText: document.data()['email'],
                icon: Icon(Icons.favorite));
          }).toList());
        }
        return Text("loading");
      },
    );
  }
}
