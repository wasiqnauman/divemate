import 'package:flutter/material.dart';

dynamic appTheme() {
  return ThemeData(
    primaryColor: Color(0xffa9cfd8),
    accentColor: Color(0xff1e3033),
  );
}

final ButtonStyle buttonStyleDark = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Color(0xff2e3131)),
    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10.0)),
    overlayColor: MaterialStateProperty.all<Color>(Color(0xfff6c7a89)),
    textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
      fontSize: 18.0,
      color: Colors.white,
    )));
