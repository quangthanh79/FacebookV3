
import 'package:facebook_auth/data/models/chat.dart';
import 'package:facebook_auth/data/models/chat_detail.dart';
import 'package:facebook_auth/icon/person_icons.dart';
import 'package:facebook_auth/screen/chat_screen/chat_detail_screen.dart';
import 'package:facebook_auth/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';




abstract class MessagePartnerItem extends StatelessWidget{
  // final MessageDetail messageDetail;
  // const MessagePartnerItem({
  //   Key? key,
  //   required this.messageDetail,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
        color: Colors.white,
        child: MaterialButton(
            onPressed: (){

            },
            focusColor: Colors.red,
            splashColor: Colors.transparent,
            highlightColor: AppTheme.grey200,
            child: getContent()
        )

    );
  }
  Widget getContent();


}