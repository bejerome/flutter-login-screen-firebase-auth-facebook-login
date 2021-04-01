import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_screen/services/authenticate.dart';

import 'getwidget.dart';

final CollectionReference usersRef =
    FirebaseFirestore.instance.collection('users');
final CollectionReference followersRef =
    FirebaseFirestore.instance.collection('follow');
final CollectionReference followingRef =
    FirebaseFirestore.instance.collection('following');
final CollectionReference activityFeedRef =
    FirebaseFirestore.instance.collection('feeds');
final currentUser = FirebaseAuth.instance.currentUser;
final DateTime timestamp = DateTime.now();

class UsersList extends StatefulWidget {
  UsersList({
    Key key,
  }) : super(key: key);
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<UsersList> {
  FireStoreUtils firestore = new FireStoreUtils();
  bool isFollowing = false;
  handleFollowers(user) async {
    var currentUserData = await firestore.getCurrentUser(currentUser.uid);
    // put that user on your following collection

    followersRef
        .doc("${user['id']}")
        .collection("userFollowers")
        .doc(currentUserData.userID)
        .set({
      "type": "followers",
      "userId": currentUserData.userID,
      "userName": currentUserData.firstName,
      "userProfileImg": currentUserData.profilePictureURL,
      "timestamp": timestamp
    });
    // Add me to users following list
    followingRef
        .doc("${currentUser.uid}")
        .collection("userFollowing")
        .doc(user['id'])
        .set({
      "type": "following",
      "userId": user['id'],
      "userName": user['firstName'],
      "userProfileImg": user['profilePictureURL'],
      "timestamp": timestamp
    });
    activityFeedRef
        .doc(user['id'])
        .collection("feedItems")
        .doc("${currentUser.uid}")
        .set({
      "type": "follow",
      "ownerId": "${user['id']}",
      "userId": "${currentUser.uid}",
      "userProfileImg": currentUserData.profilePictureURL,
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

  Future<bool> checkifFollowing(id) async {
    var result;
    await followingRef
        .doc(id)
        .collection("userFollowing")
        .doc("${currentUser.uid}")
        .get()
        .then((doc) {
      result = (doc.exists) ? true : false;
    });
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
                  handleFollowers(document.data());
                  // handleUnfollow("${document.data()['id']}");
                },
                child: isFollowing ? Text("Following") : Text("Follow"),
              ),
            );
          }).toList());
        },
      ),
    );
  }
}
