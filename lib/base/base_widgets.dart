

import 'package:facebook_auth/utils/app_theme.dart';
import 'package:flutter/material.dart';

MaterialButton buildButton(Function press, Widget? child){
  return MaterialButton(
      onPressed: ()=> press(),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all((Radius.circular(4)))),
      color: AppTheme.primary,
      child: child,
  );
}

Widget buildTextPress(String text, Color color,FontWeight fontWeight) {
  return MaterialButton(
      highlightColor: Colors.transparent,
      splashColor: AppTheme.grey500,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 22.0),
        child: new Text(
          text,
          style: TextStyle(fontSize: 16, color: color, fontWeight: fontWeight),
        ),
      ),
      onPressed: () => {});
}