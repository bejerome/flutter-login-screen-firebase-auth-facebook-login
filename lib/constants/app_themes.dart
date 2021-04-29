import 'package:flutter/material.dart';
import 'package:flutter_login_screen/constants/app_font_family.dart';

class AppThemes {
  AppThemes._();

  //constants color range for light theme
  static const Color _lightPrimaryColor = Colors.white;
  static const Color _lightPrimaryVariantColor = Colors.white;
  static const Color _lightSecondaryColor = Colors.orangeAccent;
  static const Color _lightOnPrimaryColor = Colors.white;
  static const Color _lightButtonPrimaryColor = Colors.orangeAccent;
  static const Color _lightAppBarColor = Colors.orangeAccent;

  static const Color _lightAccentColor = Color(0XFFD8ECF1);
  static Color _lightIconColor = Colors.orangeAccent;
  static Color _lightSnackBarBackgroundErrorColor = Colors.redAccent;
  static Color _lightBackgroundColor = Color(0XFFF3F5F7);

  //text theme for light theme
  static final TextStyle _lightScreenHeadingTextStyle =
      TextStyle(fontSize: 20.0, color: _lightOnPrimaryColor);
  static final TextStyle _lightScreenHeading2TextStyle =
      TextStyle(fontSize: 20.0, color: _lightSecondaryColor);
  static final TextStyle _lightScreenTaskNameTextStyle =
      TextStyle(fontSize: 16.0, color: _lightOnPrimaryColor);
  static final TextStyle _lightScreenTaskDurationTextStyle =
      TextStyle(fontSize: 14.0, color: Colors.grey);
  static final TextStyle _lightScreenButtonTextStyle = TextStyle(
      fontSize: 14.0, color: _lightOnPrimaryColor, fontWeight: FontWeight.w500);
  static final TextStyle _lightScreenCaptionTextStyle = TextStyle(
      fontSize: 12.0, color: _lightAppBarColor, fontWeight: FontWeight.w100);

  static final TextTheme _lightTextTheme = TextTheme(
    headline1: _lightScreenHeadingTextStyle,
    headline2: _lightScreenHeading2TextStyle,
    bodyText1: _lightScreenTaskNameTextStyle,
    bodyText2: _lightScreenTaskDurationTextStyle,
    button: _lightScreenButtonTextStyle,
    headline3: _lightScreenTaskNameTextStyle,
    subtitle1: _lightScreenTaskNameTextStyle,
    caption: _lightScreenCaptionTextStyle,
  );

  //constants color range for dark theme
  static const Color _darkPrimaryColor = Colors.grey;
  static const Color _darkPrimaryVariantColor = Color.fromRGBO(45, 45, 45, 1);
  static const Color _darkSecondaryColor = Colors.white;
  static const Color _darkOnPrimaryColor = Colors.white;
  static const Color _darkButtonPrimaryColor = Color.fromRGBO(195, 153, 118, 1);
  static const Color _darkAppBarColor = Color.fromRGBO(195, 153, 118, 1);
  static Color _darkIconColor = Color.fromRGBO(93, 93, 93, 1);
  static Color _darkSnackBarBackgroundErrorColor = Colors.redAccent;

  //text theme for dark theme
  static final TextStyle _darkScreenHeadingTextStyle =
      _lightScreenHeadingTextStyle.copyWith(color: _darkOnPrimaryColor);
  static final TextStyle _darkScreenHeading2TextStyle =
      _lightScreenHeadingTextStyle.copyWith(color: _darkSecondaryColor);
  static final TextStyle _darkScreenTaskNameTextStyle =
      _lightScreenTaskNameTextStyle.copyWith(color: _darkOnPrimaryColor);
  static final TextStyle _darkScreenTaskDurationTextStyle =
      _lightScreenTaskDurationTextStyle;
  static final TextStyle _darkScreenButtonTextStyle = TextStyle(
      fontSize: 14.0, color: _darkOnPrimaryColor, fontWeight: FontWeight.w500);
  static final TextStyle _darkScreenCaptionTextStyle = TextStyle(
      fontSize: 12.0, color: _darkAppBarColor, fontWeight: FontWeight.w100);

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: _darkScreenHeadingTextStyle,
    headline2: _darkScreenHeading2TextStyle,
    bodyText1: _darkScreenTaskNameTextStyle,
    bodyText2: _darkScreenTaskDurationTextStyle,
    button: _darkScreenButtonTextStyle,
    headline3: _darkScreenTaskNameTextStyle,
    subtitle1: _darkScreenTaskNameTextStyle,
    caption: _darkScreenCaptionTextStyle,
  );

  //the light theme
  static final ThemeData lightTheme = ThemeData(
    fontFamily: AppFontFamily.productSans,
    scaffoldBackgroundColor: _lightPrimaryVariantColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _lightButtonPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      color: _lightAppBarColor,
      iconTheme: IconThemeData(color: _lightOnPrimaryColor),
      textTheme: _lightTextTheme,
    ),
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      primaryVariant: _lightPrimaryVariantColor,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
    ),
    snackBarTheme:
        SnackBarThemeData(backgroundColor: _lightSnackBarBackgroundErrorColor),
    iconTheme: IconThemeData(
      color: _lightIconColor,
    ),
    popupMenuTheme: PopupMenuThemeData(color: _lightAppBarColor),
    textTheme: _lightTextTheme,
    buttonTheme: ButtonThemeData(
        buttonColor: _lightButtonPrimaryColor,
        textTheme: ButtonTextTheme.primary),
    unselectedWidgetColor: _lightPrimaryColor,
    inputDecorationTheme: InputDecorationTheme(
        fillColor: _lightPrimaryColor,
        labelStyle: TextStyle(
          color: _lightPrimaryColor,
        )),
    backgroundColor: _lightBackgroundColor,
  );

  //the dark theme
  static final ThemeData darkTheme = ThemeData(
    fontFamily: AppFontFamily.productSans,
    scaffoldBackgroundColor: _darkPrimaryVariantColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _darkButtonPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      color: _darkAppBarColor,
      iconTheme: IconThemeData(color: _darkOnPrimaryColor),
      textTheme: _darkTextTheme,
    ),
    colorScheme: ColorScheme.light(
      primary: _darkPrimaryColor,
      primaryVariant: _darkPrimaryVariantColor,
      secondary: _darkSecondaryColor,
      onPrimary: _darkOnPrimaryColor,
    ),
    snackBarTheme:
        SnackBarThemeData(backgroundColor: _darkSnackBarBackgroundErrorColor),
    iconTheme: IconThemeData(
      color: _darkIconColor,
    ),
    popupMenuTheme: PopupMenuThemeData(color: _darkAppBarColor),
    textTheme: _darkTextTheme,
    buttonTheme: ButtonThemeData(
        buttonColor: _darkButtonPrimaryColor,
        textTheme: ButtonTextTheme.primary),
    unselectedWidgetColor: _darkPrimaryColor,
    inputDecorationTheme: InputDecorationTheme(
        fillColor: _darkPrimaryColor,
        labelStyle: TextStyle(
          color: _darkPrimaryColor,
        )),
    backgroundColor: _darkPrimaryVariantColor,
  );
}
