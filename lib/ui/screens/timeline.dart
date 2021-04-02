import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_screen/constants/app_themes.dart';
import 'package:flutter_login_screen/ui/widgets/campsites_list.dart';
import 'package:flutter_login_screen/ui/widgets/following_list.dart';

final CollectionReference usersRef =
    FirebaseFirestore.instance.collection('users');
final CollectionReference postsRef =
    FirebaseFirestore.instance.collection('posts');
final CollectionReference commentsRef =
    FirebaseFirestore.instance.collection('comments');
final CollectionReference followersRef =
    FirebaseFirestore.instance.collection('followers');
final CollectionReference followingRef =
    FirebaseFirestore.instance.collection('following');
final Reference storageRef = FirebaseStorage.instance.ref();
final CollectionReference activityFeedRef =
    FirebaseFirestore.instance.collection('feeds');

final currentUser = FirebaseAuth.instance.currentUser;
final DateTime timestamp = DateTime.now();
var orientation;

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  // Set default `_initialized` and `_error` state to false
  bool initialized = false;
  bool error = false;
  bool isFollowing = false;
  // FireStoreDatabase dB = new FireStoreDatabase();
  @override
  void initState() {
    super.initState();
  }

  handleFollowers(id) {
    // put that user on your following collection
    setState(() {
      isFollowing = true;
    });
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
    setState(() {
      isFollowing = false;
    });
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

  Widget timelinePortrait() {
    return CampSiteList();
  }

  Widget landscapePortrait() {
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: width * 0.3,
          child: FollowingUsers(),
        ),
        Container(width: width * 0.65, child: CampSiteList()),
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
