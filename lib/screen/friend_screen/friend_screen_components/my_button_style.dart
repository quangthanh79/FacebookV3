

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
    padding: MaterialStatePropertyAll(padding),
    backgroundColor: MaterialStatePropertyAll(backgroundColor),
    foregroundColor: MaterialStatePropertyAll(foregroundColor),
    alignment: alignment,
    overlayColor: MaterialStatePropertyAll(overlayColor),
    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
      borderRadius: borderRadius,
      side: borderSide,
    )),
  );

}