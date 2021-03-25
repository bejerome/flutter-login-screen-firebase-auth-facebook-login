import 'package:flutter/material.dart';
import 'package:flutter_login_screen/constants.dart';
import 'package:flutter_login_screen/constants/app_themes.dart';
import 'package:flutter_login_screen/services/helper.dart';
import 'package:flutter_login_screen/ui/login/loginScreen.dart';
import 'package:flutter_login_screen/ui/signUp/signUpScreen.dart';
import 'package:flutter_login_screen/ui/widgets/custom_button.dart';
import 'package:flutter_login_screen/ui/widgets/google_button.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.lightTheme.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Icon(
              Icons.phone_iphone,
              size: 150,
              color: Color(COLOR_PRIMARY),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 32, right: 16, bottom: 8),
            child: Text(
              'MY App!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(COLOR_PRIMARY),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Signatra"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 40),
            child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: CustomButton(
                  buttonText: "Login",
                  onPressedCallBack: () => push(context, new LoginScreen()),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 40),
            child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: CustomButton(
                  buttonText: 'Sign Up',
                  onPressedCallBack: () => push(context, new SignUpScreen()),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 40),
            child: GoogleButton(),
          )
        ],
      ),
    );
  }
}
