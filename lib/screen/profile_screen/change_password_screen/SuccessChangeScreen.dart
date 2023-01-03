

import 'dart:async';

import 'package:facebook_auth/screen/home_screen/post_item/post_item.dart';
import 'package:facebook_auth/utils/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../login/login_screen.dart';

class SuccessChangeScreen extends StatelessWidget{

  SuccessChangeScreen(Key? key, BuildContext context) : super(key: key){
    Timer.periodic(Duration(seconds: 2), (timer) {
      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen()),
                            (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,),
          child:  Center(child: Icon(Icons.check_circle_outline_outlined, color: AppTheme.primary,),),
        )
    );
  }

}