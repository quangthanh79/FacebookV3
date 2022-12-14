

import 'package:flutter/material.dart';

import '../app_theme.dart';

Widget getAppBar(BuildContext context, String content) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: AppTheme.grey500),
      ),
    ),
    child: Row(
      children: [
        SizedBox(width: 10),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          splashRadius: 20,
          icon: Icon(
            Icons.arrow_back,
            size: 22,
          ),
        ),
        Text(
          content,
          style: TextStyle(fontSize: 18),
        )
      ],
    ),
  );
}
Widget getAppBar2(BuildContext context, String content) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: AppTheme.grey500),
      ),
    ),
    child: Row(
      children: [
        SizedBox(width: 15),
        Padding(
            padding: EdgeInsets.only(top: 15,bottom: 15),
            child: Text(
              content,
              style: TextStyle(fontSize: 18),
            ),
        )
      ],
    ),
  );
}