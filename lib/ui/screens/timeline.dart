import 'package:flutter/material.dart';
import 'package:flutter_login_screen/constants/app_themes.dart';

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
    return Scaffold(
      backgroundColor: AppThemes.lightTheme.backgroundColor,
      body: Center(
          child: Container(
              child: Text(
        "Timeline",
        style:
            TextStyle(fontSize: 30, fontFamily: "Signatra", color: Colors.red),
      ))),
    );
  }
}
