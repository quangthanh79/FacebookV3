
import 'package:facebook_auth/data/models/chat.dart';
import 'package:facebook_auth/icon/person_icons.dart';
import 'package:facebook_auth/screen/chat_screen/chat_detail_screen.dart';
import 'package:facebook_auth/utils/app_theme.dart';
import 'package:facebook_auth/utils/image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';




class ConversationItem extends StatelessWidget{
  final Conversation conversation;
  const ConversationItem({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
        color: Colors.white,
        child: MaterialButton(
          onPressed: (){
            Navigator.push(
                context,
                ChatDetailScreen.route(conversation.partner!)
            );
          },
          focusColor: Colors.red,
          splashColor: Colors.transparent,
          highlightColor: AppTheme.grey200,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: getImage(
                  uri: conversation.partner?.avatar ?? 'assets/images/default_avatar_image.jpg',
                  defaultUri: 'assets/images/default_avatar_image.jpg',
                  width: 60,
                  height: 60,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      conversation.partner!.username != null ?
                      Text(
                          conversation.partner!.username!,
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16)
                      ):
                      const Text(
                        "Người dùng Facebook",
                        style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          _getLastMessage(),
                          SizedBox(width: 10),
                          Text("."),
                          SizedBox(width: 10),
                          Text(
                            _getTime(),
                            style: conversation.lastMessage!.unread! != 0?
                            TextStyle(fontWeight: FontWeight.bold,fontSize: 15):
                            TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  )
              )
            ],
          )
        )

    );

  }
  Widget _getLastMessage(){
      if(conversation.lastMessage!.senderId! == conversation.partner!.id!){
        return Flexible(
            child: Text(
              conversation.lastMessage!.message!,
              overflow: TextOverflow.ellipsis,
              style: conversation.lastMessage!.unread! != 0?
              TextStyle(fontWeight: FontWeight.bold,fontSize: 15):
              TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
            )
        );
      }else{
        return Flexible(
            child: Text(
              conversation.lastMessage!.message!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
            )
        );
      }

  }
  String _getTime(){
    int? dateInt = int.tryParse(conversation.lastMessage!.created!);
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(dateInt!);
    var diff = now.difference(date);
    var time = '';
    if(diff.inDays == 0){
      var format = DateFormat('HH:mm');
      time = format.format(date);
    }else{
      var format = DateFormat('dd/MM/yyyy');
      time = format.format(date);
    }
    return time;
  }

}