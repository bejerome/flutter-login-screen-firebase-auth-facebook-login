// The basic skeleton structure of the widget

import 'package:flutter/material.dart';
import 'package:flutter_login_screen/ui/widgets/google_button.dart';

class AuthDialog extends StatefulWidget {
  @override
  _AuthDialogState createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // ...
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Email address'),
                TextField(decoration: InputDecoration(hintText: "Email")),
                Text('Password'),
                TextField(decoration: InputDecoration(hintText: "Password")),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.maxFinite,
                        child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Log in',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.maxFinite,
                        child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Sign up',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(child: GoogleButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
