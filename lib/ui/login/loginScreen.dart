import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_login_screen/constants.dart';
import 'package:flutter_login_screen/main.dart';
import 'package:flutter_login_screen/model/user.dart';
import 'package:flutter_login_screen/providers/app_providers.dart';
import 'package:flutter_login_screen/services/authenticate.dart';
import 'package:flutter_login_screen/services/helper.dart';
import 'package:flutter_login_screen/ui/home/homeScreen.dart';
import 'package:flutter_login_screen/ui/widgets/custom_button.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

var orientation;

class LoginScreen extends StatefulWidget {
  @override
  State createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  GlobalKey<FormState> _key = new GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  String email = '', password = '';

  @override
  Widget build(BuildContext context) {
    // orientation = MediaQuery.of(context).orientation;
    var widthPortrait = MediaQuery.of(context).size.width;
    var widthLandscape = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          width: (UniversalPlatform.isWeb || UniversalPlatform.isMacOS)
              ? widthLandscape
              : widthPortrait,
          child: Form(
            key: _key,
            autovalidateMode: _validate,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding:
                      (UniversalPlatform.isWeb || UniversalPlatform.isMacOS)
                          ? const EdgeInsets.only(
                              top: 10, right: 16.0, left: 16.0, bottom: 10.0)
                          : const EdgeInsets.only(
                              top: 200, right: 16.0, left: 16.0, bottom: 10.0),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        color: Color(COLOR_PRIMARY),
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: double.infinity),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 32.0, right: 24.0, left: 24.0),
                    child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.next,
                        validator: validateEmail,
                        onSaved: (String val) {
                          email = val;
                        },
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                        style: TextStyle(fontSize: 18.0),
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Color(COLOR_PRIMARY),
                        decoration: InputDecoration(
                            contentPadding:
                                new EdgeInsets.only(left: 16, right: 16),
                            fillColor: Colors.white,
                            hintText: 'E-mail Address',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                    color: Color(COLOR_PRIMARY), width: 2.0)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ))),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: double.infinity),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 32.0, right: 24.0, left: 24.0),
                    child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        validator: validatePassword,
                        onSaved: (String val) {
                          password = val;
                        },
                        onFieldSubmitted: (password) async {
                          await login();
                        },
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        cursorColor: Color(COLOR_PRIMARY),
                        decoration: InputDecoration(
                            contentPadding:
                                new EdgeInsets.only(left: 16, right: 16),
                            fillColor: Colors.white,
                            hintText: 'Password',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                    color: Color(COLOR_PRIMARY), width: 2.0)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ))),
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(right: 40.0, left: 40.0, top: 40),
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(minWidth: double.infinity),
                      child: CustomButton(
                          buttonText: "Login",
                          onPressedCallBack: () {
                            login();
                          }),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      showProgress(context, 'Logging in, please wait...', false);
      User user = await loginWithUserNameAndPassword();
      if (user != null)
        pushAndRemoveUntil(context, HomeScreen(user: user), false);
    } else {
      setState(() {
        _validate = AutovalidateMode.onUserInteraction;
      });
    }
  }

  Future<User> loginWithUserNameAndPassword() async {
    // bool isIos = UniversalPlatform.isIOS;
    // bool isWeb = UniversalPlatform.isWeb;
    auth.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    try {
      auth.UserCredential result = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      DocumentSnapshot documentSnapshot = await FireStoreUtils.firestore
          .collection(USERS)
          .doc(result.user.uid)
          .get();
      User user;
      if (documentSnapshot != null && documentSnapshot.exists) {
        user = User.fromJson(documentSnapshot.data());
        user.active = true;
        await FireStoreUtils.updateCurrentUser(user);
        hideProgress();
        MyAppState.currentUser = user;
        Provider.of<AppProvider>(context, listen: false)
            .storeCurrentUser(currentUser: user);
      }
      return user;
    } on auth.FirebaseAuthException catch (exception) {
      hideProgress();
      switch ((exception).code) {
        case "invalid-email":
          showAlertDialog(context, 'Couldn\'t Authenticate', 'malformedEmail');
          break;
        case "wrong-password":
          showAlertDialog(context, 'Couldn\'t Authenticate', 'Wrong password');
          break;
        case "user-not-found":
          showAlertDialog(context, 'Couldn\'t Authenticate',
              'No user corresponds to this email');
          break;
        case "user-disabled":
          showAlertDialog(
              context, 'Couldn\'t Authenticate', 'This user is disabled');
          break;
        case 'too-many-requests':
          showAlertDialog(context, 'Couldn\'t Authenticate',
              'Too many requests, Please try again later.');
          break;
      }
      print(exception.toString());
      return null;
    } catch (e) {
      hideProgress();
      showAlertDialog(
          context, 'Couldn\'t Authenticate', 'Login failed. Please try again.');
      print(e.toString());
      return null;
    }
  }

  void _createUserFromFacebookLogin(
      FacebookLoginResult result, String userID) async {
    final token = result.accessToken.token;
    final graphResponse = await http.get('https://graph.facebook.com/v2'
        '.12/me?fields=name,first_name,last_name,email,picture.type(large)&access_token=$token');
    final profile = json.decode(graphResponse.body);
    User user = User(
        firstName: profile['first_name'],
        lastName: profile['last_name'],
        email: profile['email'],
        profilePictureURL: profile['picture']['data']['url'],
        active: true,
        userID: userID);
    await FireStoreUtils.firestore
        .collection(USERS)
        .doc(userID)
        .set(user.toJson())
        .then((onValue) {
      MyAppState.currentUser = user;
      hideProgress();
      pushAndRemoveUntil(context, HomeScreen(user: user), false);
    });
  }

  void _syncUserDataWithFacebookData(
      FacebookLoginResult result, User user) async {
    final token = result.accessToken.token;
    final graphResponse = await http.get('https://graph.facebook.com/v2'
        '.12/me?fields=name,first_name,last_name,email,picture.type(large)&access_token=$token');
    final profile = json.decode(graphResponse.body);
    user.profilePictureURL = profile['picture']['data']['url'];
    user.firstName = profile['first_name'];
    user.lastName = profile['last_name'];
    user.email = profile['email'];
    user.active = true;
    await FireStoreUtils.updateCurrentUser(user);
    MyAppState.currentUser = user;
    hideProgress();
    pushAndRemoveUntil(context, HomeScreen(user: user), false);
  }
}
