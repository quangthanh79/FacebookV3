import 'package:flutter/material.dart';

import 'app_theme.dart';

class Button{
  static Widget buildButtonPrimary(BuildContext context,String content, Function? function) {
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SizedBox(
            width: double.infinity,
            height: 42,
            child: MaterialButton(
              onPressed: () => {
                if(function != null){
                  function()
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all((Radius.circular(4)))),
              color: AppTheme.primary,
              child: buildContent(content, Colors.white),
            )
        ));
  }
  static Widget buildButtonGrey(BuildContext context,String content, Function? function) {
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SizedBox(
            width: double.infinity,
            height: 42,
            child: MaterialButton(
              onPressed: () => {
                if(function != null){
                  function()
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all((Radius.circular(4)))),
              color: AppTheme.grey200,
              child: buildContent(content, Colors.black),
            )
        ));
  }

  static Widget buildContent(String content, Color colorContent) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        content,
        maxLines: 1,
        textAlign: TextAlign.center,
        overflow: TextOverflow.fade,
        style: TextStyle(
            fontWeight: FontWeight.normal, fontSize: 15.0, color: colorContent),
      ),
    );
  }
}