import 'package:flutter/material.dart';

class MenuText extends StatelessWidget {
  final String label;
  final Widget screen;
  final Function toggle;
  final String route;
  const MenuText({Key key, this.label, this.screen, this.toggle, this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: GestureDetector(
        onTap: () {
          toggle();
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => screen));
        },
        child: Text(
          label,
          style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: 'Montserrat',
              fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
