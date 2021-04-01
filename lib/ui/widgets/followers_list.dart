import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'getwidget.dart';

final CollectionReference usersRef =
    FirebaseFirestore.instance.collection('users');
final CollectionReference followersRef =
    FirebaseFirestore.instance.collection('followers');
final CollectionReference followingRef =
    FirebaseFirestore.instance.collection('following');
final CollectionReference activityFeedRef =
    FirebaseFirestore.instance.collection('feeds');
final currentUser = FirebaseAuth.instance.currentUser;
final DateTime timestamp = DateTime.now();

class FollowersUsers extends StatefulWidget {
  FollowersUsers({
    Key key,
  }) : super(key: key);
  _FollowersUsersState createState() => _FollowersUsersState();
}

class _FollowersUsersState extends State<FollowersUsers> {
  handleFollowers(id) {
    // put that user on your following collection

    followersRef
        .doc("${currentUser.uid}")
        .collection("userFollowers")
        .doc(id)
        .set({});
    // Add me to users following list
    followingRef
        .doc(id)
        .collection("userFollowing")
        .doc("${currentUser.uid}")
        .set({});
    activityFeedRef
        .doc(id)
        .collection("feedItems")
        .doc("${currentUser.uid}")
        .set({
      "type": "follow",
      "ownerId": "$id",
      "userId": "${currentUser.uid}",
      "userProfileImg": currentUser.photoURL,
      "timestamp": timestamp
    });
  }

  handleUnfollow(id) {
    // put that user on your following collection

    followersRef
        .doc("${currentUser.uid}")
        .collection("userFollowers")
        .doc(id)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    // Add me to users following list
    followingRef
        .doc(id)
        .collection("userFollowing")
        .doc("${currentUser.uid}")
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    activityFeedRef
        .doc(id)
        .collection("feedItems")
        .doc("${currentUser.uid}")
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  Future<QuerySnapshot> checkifFollowing() async {
    var result = await FirebaseFirestore.instance
        .collection("followers")
        .doc(currentUser.uid)
        .collection("userFollowers")
        .get()
        .then((doc) => doc);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
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
            return GFListTile(
              padding: EdgeInsets.zero,
              avatar: GFAvatar(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: CachedNetworkImage(
                        imageUrl: "${document.data()['profilePictureURL']}")),
              ),
              title: Text(document.data()['firstName']),
              subTitle: Text(
                document.data()['email'],
                style: TextStyle(fontSize: 10),
              ),
              icon: OutlinedButton(
                onPressed: () {
                  // handleFollowers("${document.data()['id']}");
                  // handleUnfollow("${document.data()['id']}");
                },
                child: Text("Following"),
              ),
            );
          }).toList());
        },
      ),
    );
  }
}
