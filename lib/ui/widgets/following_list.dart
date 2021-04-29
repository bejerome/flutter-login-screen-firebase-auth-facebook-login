import 'dart:async';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_login_screen/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_screen/providers/app_providers.dart';
import 'package:flutter_login_screen/ui/widgets/profile_dialog.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

import 'getwidget.dart';

final CollectionReference usersRef =
    FirebaseFirestore.instance.collection('users');
final CollectionReference followersRef =
    FirebaseFirestore.instance.collection('followers');
final CollectionReference followingRef =
    FirebaseFirestore.instance.collection('following');
final CollectionReference activityFeedRef =
    FirebaseFirestore.instance.collection('feeds');
final DateTime timestamp = DateTime.now();

class FollowingUsers extends StatefulWidget {
  _FollowingUsersState createState() => _FollowingUsersState();
}

class _FollowingUsersState extends State<FollowingUsers>
    with TickerProviderStateMixin {
  AnimationController animController;
  Stream<dynamic> following;
  User currentUser;
  @override
  void initState() {
    super.initState();
    currentUser = Provider.of<AppProvider>(context, listen: false).currentUser;
    animController =
        AnimationController(vsync: this, duration: Duration(seconds: 30))
          ..repeat();
  }

  handleFollowers(id) {
    // put that user on your following collection

    followersRef
        .doc("${currentUser.userID}")
        .collection("userFollowers")
        .doc(id)
        .set({});
    // Add me to users following list
    followingRef
        .doc(id)
        .collection("userFollowing")
        .doc("${currentUser.userID}")
        .set({});
    activityFeedRef
        .doc(id)
        .collection("feedItems")
        .doc("${currentUser.userID}")
        .set({
      "type": "follow",
      "ownerId": "$id",
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
        .doc("${currentUser.userID}")
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
        .doc("${currentUser.userID}")
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

    setState(() {
      following = followingRef
          .doc("${currentUser.userID}")
          .collection("userFollowing")
          .get()
          .then((doc) => doc)
          .asStream();
    });
  }

  Future<QuerySnapshot> checkifFollowing() async {
    var result = await FirebaseFirestore.instance
        .collection("following")
        .doc("${currentUser.userID}")
        .collection("userFollowing")
        .get()
        .then((doc) => doc);
    return result;
  }

  Widget animatedLogo() {
    final animation = Tween(begin: 0, end: 2 * pi).animate(animController);
    return AnimatedBuilder(
        animation: animation,
        child: Container(
          color: Colors.red,
          width: 2,
          height: 2,
        ),
        builder: (context, child) {
          return Transform.rotate(
            angle: animation.value,
            child: child,
          );
        });
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: StreamBuilder<QuerySnapshot>(
        stream: followingRef
            .doc("${currentUser.userID}")
            .collection("userFollowing")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text(
                "Something went wrong getting followings: ${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GFLoader(
              type: GFLoaderType.circle,
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return OpenContainer(
                    transitionType: ContainerTransitionType.fadeThrough,
                    closedElevation: 0,
                    closedColor: Colors.transparent,
                    openBuilder: (context, action) {
                      return animatedLogo();
                    },
                    closedBuilder: (context, action) {
                      return GFListTile(
                        padding: EdgeInsets.zero,
                        avatar: GFAvatar(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: UniversalPlatform.isWeb
                                  ? Image(
                                      image: NetworkImage(
                                          "${snapshot.data.docs[index].data()['userProfileImg']}"))
                                  : CachedNetworkImage(
                                      imageUrl:
                                          "${snapshot.data.docs[index].data()['userProfileImg']}")),
                        ),
                        title:
                            Text(snapshot.data.docs[index].data()['userName']),
                        icon: OutlinedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => ProfileDialog());
                            // handleUnfollow(
                            //     "${snapshot.data.docs[index].data()['userId']}");
                          },
                          child: Text("Following"),
                        ),
                      );
                    },
                  );
                });
          } else {
            return Container(
              height: 0.0,
              width: 0.0,
            );
          }
        },
      ),
    );
  }
}
