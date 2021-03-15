import 'package:flutter/material.dart';
import 'package:flutter_login_screen/constants/app_themes.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.lightTheme.backgroundColor,
      body: Center(
        child: Container(
          child: Text(
            "Upload",
            style: TextStyle(
                fontSize: 30, fontFamily: "Signatra", color: Colors.red),
          ),
        ),
      ),
    );
  }
}
