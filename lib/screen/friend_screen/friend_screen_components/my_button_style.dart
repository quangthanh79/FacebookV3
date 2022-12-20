

import 'package:flutter/material.dart';

class MyButtonStyle extends ButtonStyle{
  MyButtonStyle({
    EdgeInsets padding = const EdgeInsets.all(8),
    Color backgroundColor = Colors.black12,
    Color? foregroundColor,
    Alignment alignment = Alignment.center,
    Color overlayColor = Colors.black12,
    BorderRadiusGeometry borderRadius = BorderRadius.zero,
    BorderSide borderSide = BorderSide.none,
  }) : super(
    padding: MaterialStateProperty.all(padding),
    backgroundColor: MaterialStateProperty.all(backgroundColor),
    foregroundColor: MaterialStateProperty.all(foregroundColor),
    alignment: alignment,
    overlayColor: MaterialStateProperty.all(overlayColor),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: borderRadius,
      side: borderSide,
    )),
  );
}