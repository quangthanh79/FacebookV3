

import 'package:facebook_auth/data/models/chat.dart';
import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/page_data.dart';
import 'package:facebook_auth/data/repository/chat_repository.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:facebook_auth/icon/camera_icons.dart';
import 'package:facebook_auth/icon/pencil_icons.dart';
import 'package:facebook_auth/screen/chat_screen/blocs/chat_blocs/chat_bloc.dart';
import 'package:facebook_auth/screen/chat_screen/blocs/chat_blocs/chat_state.dart';
import 'package:facebook_auth/screen/chat_screen/camera_screen.dart';

import 'package:facebook_auth/screen/chat_screen/conversation_item/conversation_item.dart';
import 'package:facebook_auth/screen/chat_screen/friend_item/friend_item.dart';
import 'package:facebook_auth/screen/home_screen/home_bloc/home_bloc.dart';
import 'package:facebook_auth/utils/app_theme.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:facebook_auth/utils/widget/load_more_widget_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lottie/lottie.dart';

import '../../data/models/friend_chat.dart';
import 'blocs/chat_blocs/chat_event.dart';

class ChatBody extends StatelessWidget{
  final chatBloc = ChatBloc(getIt.get<ChatRepository>(),getIt.get<FriendRepository>());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => chatBloc,
      child: BlocListener<ChatBloc,ChatState>(
        listener: (context,state){
          if(state.statusHasMessgage == StatusHasMessgage.SendMessage){
            print("COMPARE SHOW SNACK BAR");
            //  SnackBar snackBar = SnackBar(
            //   content: Text(state.message),
            //   duration: Duration(seconds: 1),
            // );
            // ScaffoldMessenger.of(context)
            //   ..hideCurrentMaterialBanner()
            //   ..showSnackBar(snackBar);
          }
        },
        child: getContentPage(context),
      )
    );
  }
  Widget getContentPage(BuildContext context){
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 15,right: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 49,
            ),
            Row(
            children: [
              const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "Đoạn chat",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  )
              ),
              InkWell(
                onTap: (){
                  print("Open Camera");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CameraScreen(),
                      ));
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 40,
                  width: 40,
                  child: Container(
                      child: Icon(Camera.photo_camera,size: 23)
                  ),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppTheme.grey200),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                height: 40,
                width: 40,
                child: Container(
                    child: Icon(Pencil.pencil,size: 16)
                ),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppTheme.grey200),
              )
            ],
          ),
            getContentListFriend(),
            getContentListConversation()
          ],
        ),
      ),
    );
  }
  Widget getContentListConversation(){
    return Expanded(
        child: LoadMoreWidget2<Conversation>(
            onLoadData: (page) async {
              var response = await chatBloc.tryFetchListConversation(page);
              return PageData(
                  code: response?.code,
                  message: response?.message,
                  data: response?.data);
            },
            itemBuilder: (item)=> ConversationItem(conversation: item),
            itemNoData: const Center(
              child: Text(
                "You have not conversation!"
              ),
            )
        )
    );
  }
  Widget getContentListFriend(){
    return Container(
      height: 100,
      color: Colors.white,
      child: LoadMoreWidget2<Friends>(
          onLoadData: (page) async {
            var response = await chatBloc.tryFetchListFriend(page);
            print("RESPONSE: " + (response ?? 1).toString());
            response?.data?.friends?.forEach((element) {
              print("---------ID: "+ element.user_id.toString());
            });
            print("FRIENDS: " + (response?.data?.friends ?? 1).toString());
            return PageData(
                code: response?.code,
                message: response?.message,
                data: response?.data?.friends);
          },
          itemBuilder: (item){
            return FriendItem(friend: item);
          },
          axisContent: Axis.horizontal,
          itemNoData: Container(
            height: 90,
            child: const Center(
              child: Text(
                  "You have not friend!"
              ),
            )
          )
      ),
    );
  }
  Future<void> _pullRefresh() async {
    return Future<void>.delayed(const Duration(seconds: 3));
  }
}