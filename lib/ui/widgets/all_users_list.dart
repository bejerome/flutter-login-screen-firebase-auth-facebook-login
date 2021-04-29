import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_login_screen/model/user.dart';
import 'package:flutter_login_screen/providers/app_providers.dart';
import 'package:flutter_login_screen/services/authenticate.dart';
import 'package:provider/provider.dart';

import 'getwidget.dart';

final CollectionReference usersRef =
    FirebaseFirestore.instance.collection('users');
final CollectionReference followersRef =
    FirebaseFirestore.instance.collection('follow');
final CollectionReference followingRef =
    FirebaseFirestore.instance.collection('following');
final CollectionReference activityFeedRef =
    FirebaseFirestore.instance.collection('feeds');

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
  User currentUser;
  @override
  void initState() {
    currentUser = Provider.of<AppProvider>(context, listen: false).currentUser;
    super.initState();
  }

  handleFollowers(user) async {
    // put that user on your following collection

    followersRef
        .doc("${user['id']}")
        .collection("userFollowers")
        .doc(currentUser.userID)
        .set({
      "type": "followers",
      "userId": currentUser.userID,
      "userName": currentUser.firstName,
      "userProfileImg": currentUser.profilePictureURL,
      "timestamp": timestamp
    });
    // Add me to users following list
    followingRef
        .doc("${currentUser.userID}")
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
        .doc("${currentUser.userID}")
        .set({
      "type": "follow",
      "ownerId": "${user['id']}",
      "userId": "${currentUser.userID}",
      "userProfileImg": currentUser.profilePictureURL,
      "timestamp": timestamp
    });
  }

  handleUnfollow(id) {
    // put that user on your following collection

    followersRef
        .doc("${currentUser.userID}")
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
        .doc("${currentUser.userID}")
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    activityFeedRef
        .doc(id)
        .collection("feedItems")
        .doc("${currentUser.userID}")
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
        .doc("${currentUser.userID}")
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
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong on loading users on search");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return GFLoader(
                  type: GFLoaderType.circle,
                );
              }

              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return GFListTile(
                    padding: EdgeInsets.zero,
                    avatar: GFAvatar(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: CachedNetworkImage(
                              imageUrl:
                                  "${snapshot.data.docs[index].data()['profilePictureURL']}")),
                    ),
                    title: Text(snapshot.data.docs[index].data()['firstName']),
                    subTitle: Text(
                      snapshot.data.docs[index].data()['email'],
                      style: TextStyle(fontSize: 10),
                    ),
                    icon: OutlinedButton(
                      onPressed: () {
                        handleFollowers(snapshot.data.docs[index].data());
                        // handleUnfollow("${document.data()['id']}");
                      },
                      child: isFollowing ? Text("Following") : Text("Follow"),
                    ),
                  );
                },
              );
            }));
  }
}
