
import 'package:facebook_auth/screen/chat_screen/chat_body.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen>
    with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return ChatBody();
  }



  /**
   * method wantKeepAlive to keep state when slide among Tabviews
   */
  @override
  bool get wantKeepAlive => true;
}
