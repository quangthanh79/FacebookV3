
import 'package:facebook_auth/data/models/chat.dart';
import 'package:facebook_auth/data/models/chat_detail.dart';
import 'package:facebook_auth/icon/person_icons.dart';
import 'package:facebook_auth/screen/chat_screen/chat_detail_screen.dart';
import 'package:facebook_auth/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';




class MessageItem extends StatelessWidget{
  final MessageDetail messageDetail;
  const MessageItem({
    Key? key,
    required this.messageDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: MaterialButton(
            onPressed: (){

            },
            focusColor: Colors.red,
            splashColor: Colors.transparent,
            highlightColor: AppTheme.grey200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 50),
                Flexible(
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.primaryPurple,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                          child: Text(
                            messageDetail.message!,
                            maxLines: null,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 16
                            ),
                          )
                      )
                  ),
                ),
              ],
            )
        )

    );

  }
  //
  // String _getTime(){
  //   int? dateInt = int.tryParse(conversation.lastMessage!.created!);
  //   var now = DateTime.now();
  //   var date = DateTime.fromMillisecondsSinceEpoch(dateInt!);
  //   var diff = now.difference(date);
  //   var time = '';
  //   if(diff.inDays == 0){
  //     var format = DateFormat('HH:mm');
  //     time = format.format(date);
  //   }else{
  //     var format = DateFormat('dd/MM/yyyy');
  //     time = format.format(date);
  //   }
  //   return time;
  // }

}