import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function onPressedCallBack;

  const CustomButton({Key key, this.buttonText, this.onPressedCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                fontFamily: "Signatra",
                color: Color(COLOR_PRIMARY)),
          ),
        ),
        style: ButtonStyle(
          shadowColor: MaterialStateProperty.all<Color>(Color(COLOR_PRIMARY)),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          elevation: MaterialStateProperty.all<double>(10.0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(
                color: Color(COLOR_PRIMARY),
              ),
            ),
          ),
        ),
        onPressed: () async {
          await onPressedCallBack();
        },
      ),
    );
  }
}
