import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_screen/ui/widgets/all_users_list.dart';

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

class FollowingUsers extends StatefulWidget {
  FollowingUsers({
    Key key,
  }) : super(key: key);
  _FollowingUsersState createState() => _FollowingUsersState();
}

class _FollowingUsersState extends State<FollowingUsers> {
  Stream<dynamic> following;
  @override
  void initState() {
    following = followingRef
        .doc(currentUser.uid)
        .collection("userFollowing")
        .get()
        .then((doc) => doc)
        .asStream();
    super.initState();
  }

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
        .doc("${currentUser.uid}")
        .collection("userFollowing")
        .doc(id)
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

    setState(() {
      following = followingRef
          .doc(currentUser.uid)
          .collection("userFollowing")
          .get()
          .then((doc) => doc)
          .asStream();
    });
  }

  Future<QuerySnapshot> checkifFollowing() async {
    var result = await FirebaseFirestore.instance
        .collection("following")
        .doc(currentUser.uid)
        .collection("userFollowing")
        .get()
        .then((doc) => doc);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: StreamBuilder<QuerySnapshot>(
        stream: following,
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
              padding: EdgeInsets.zero,
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return GFListTile(
                  padding: EdgeInsets.zero,
                  avatar: GFAvatar(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: CachedNetworkImage(
                            imageUrl: "${document.data()['userProfileImg']}")),
                  ),
                  title: Text(document.data()['userName']),
                  icon: OutlinedButton(
                    onPressed: () {
                      handleUnfollow("${document.data()['userId']}");
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
