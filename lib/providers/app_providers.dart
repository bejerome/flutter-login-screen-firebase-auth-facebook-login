import 'package:flutter/material.dart';
import 'package:flutter_login_screen/model/user.dart';

class AppProvider extends ChangeNotifier {
  User user;
  User get currentUser => this.user;
  void storeCurrentUser({User currentUser}) {
    user = currentUser;
  }
}
