import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_login_screen/constants/app_themes.dart';
import 'package:flutter_login_screen/model/user.dart';

import 'package:flutter_login_screen/ui/widgets/header.dart';
import 'package:flutter_login_screen/ui/widgets/progress.dart';
import 'package:flutter_svg/svg.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot> searchResultsFuture;
  // handleSearch(String query) async {
  //   Future<QuerySnapshot> users =
  //       usersRef.where("displayName", isEqualTo: query).get();

  //   setState(() {
  //     searchResultsFuture = users;
  //   });
  // }

  // AppBar buildSearchField() {
  //   return AppBar(
  //     backgroundColor: Colors.white,
  //     title: TextFormField(
  //       controller: searchController,
  //       decoration: InputDecoration(
  //           hintText: "Search for user...",
  //           filled: true,
  //           prefixIcon: Icon(
  //             Icons.account_box,
  //             size: 28.0,
  //           ),
  //           suffixIcon: IconButton(
  //             icon: Icon(Icons.clear),
  //             onPressed: () {
  //               searchController.clear();
  //             },
  //           )),
  //       onFieldSubmitted: (value) {},
  //     ),
  //   );
  // }

  Container buildNoContent() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            SvgPicture.asset(
              'assets/images/search.svg',
              height: orientation == orientation ? 300.0 : 200,
            ),
            Text(
              "Find Users",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontFamily: "Signatra",
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }

  builSearchResults() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppThemes.lightTheme.backgroundColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                searchResultsFuture == null
                    ? buildNoContent()
                    : builSearchResults(),
              ]),
        ));
  }
}

class UserResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomHeader(
          isAppTitle: false,
          isSearchBar: true,
          signOutCallBack: null,
        ),
        body: Center(
          child: Text(
            'Activity Feed Item',
            style: TextStyle(fontSize: 20, fontFamily: "Signatra"),
          ),
        ));
  }
}
