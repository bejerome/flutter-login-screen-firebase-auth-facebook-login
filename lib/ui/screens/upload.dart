import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_login_screen/constants/app_themes.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> with TickerProviderStateMixin {
  AnimationController _animController;
  @override
  void initState() {
    super.initState();
    _animController =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();
  }

  void clickContainer() {
    if (_animController.status == AnimationStatus.completed) {
      _animController.reverse();
    } else if (_animController.status == AnimationStatus.dismissed) {
      _animController.forward();
    } else {
      _animController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final animation =
        Tween(begin: 10.0, end: 110 * pi).animate(_animController);
    return Scaffold(
      backgroundColor: AppThemes.lightTheme.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                clickContainer();
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: AnimatedLogo(
                  animation: animation,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, @required Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Stack(children: [
      Positioned(
        left: animation.value,
        child: Container(
          child: Text(
            "Upload",
            style: TextStyle(
                fontSize: 30, fontFamily: "Signatra", color: Colors.red),
          ),
        ),
      ),
    ]);
  }
}
