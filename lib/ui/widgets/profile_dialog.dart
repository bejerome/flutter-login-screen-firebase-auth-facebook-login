// The basic skeleton structure of the widget

import 'package:flutter/material.dart';
import 'package:flutter_login_screen/ui/widgets/google_button.dart';

class ProfileDialog extends StatefulWidget {
  @override
  _ProfileDialogState createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // ...
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [Container()],
            ),
          ),
        ),
      ),
    );
  }
}
