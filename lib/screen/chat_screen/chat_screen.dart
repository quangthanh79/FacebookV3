
import 'package:facebook_auth/data/models/chat.dart';
import 'package:facebook_auth/data/models/friend_chat.dart';
import 'package:facebook_auth/data/models/page_data.dart';
import 'package:facebook_auth/data/repository/chat_repository.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:facebook_auth/icon/camera_icons.dart';
import 'package:facebook_auth/icon/pencil_icons.dart';
import 'package:facebook_auth/screen/chat_screen/blocs/chat_blocs/chat_bloc.dart';
import 'package:facebook_auth/screen/chat_screen/blocs/chat_blocs/chat_event.dart';
import 'package:facebook_auth/screen/chat_screen/blocs/chat_blocs/chat_state.dart';
import 'package:facebook_auth/screen/chat_screen/camera_screen.dart';
import 'package:facebook_auth/screen/chat_screen/conversation_item/conversation_item.dart';
import 'package:facebook_auth/screen/chat_screen/friend_item/friend_item.dart';
import 'package:facebook_auth/utils/app_theme.dart';
import 'package:facebook_auth/utils/image.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:facebook_auth/utils/widget/load_more_widget_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen>
    with AutomaticKeepAliveClientMixin {
  final chatBloc = ChatBloc(getIt.get<ChatRepository>(),getIt.get<FriendRepository>());
  int countReload = 0;
  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => chatBloc,
        child: getContentPage()
    );
  }
  Widget getContentPage(){
    return BlocBuilder<ChatBloc,ChatState>(
        builder: (context,state){
          print("Build CONTENT PAGE");
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
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                            width: 70,
                            height: 100,
                            color: Colors.white,
                            child: CupertinoButton(
                                onPressed: (){
                                },
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Column(

                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: getImage(
                                            uri: SessionUser.user?.avatar ?? 'assets/images/default_avatar_image.jpg',
                                            defaultUri: 'assets/images/default_avatar_image.jpg',
                                            width: 60,
                                            height: 60,
                                          ),
                                        ),
                                        Positioned(
                                            right: -10,
                                            top: -10,
                                            child: GestureDetector(
                                              child: Container(
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(100),
                                                    color: Colors.white
                                                ),
                                                child: const Icon(
                                                  Icons.add,
                                                  color: AppTheme.grey500,
                                                  size: 20,
                                                ),
                                              ),
                                              onTap: (){},
                                            )
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Expanded(child: Container(
                                            color: Colors.white,
                                            child: const Text(
                                              "Tạo trạng thái",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400
                                              ),
                                              textAlign: TextAlign.center,
                                            )
                                        ))
                                      ],
                                    )


                                  ],
                                )
                            )

                        ),
                        Expanded(child: getContentListFriend())
                      ],
                    ),
                    getContentListConversation()
                  ],
                )
            ),
          );
        }
    );
  }
  Widget getContentListConversation(){
    return BlocBuilder<ChatBloc,ChatState>(
        builder: (context,state){
          return Expanded(
              child: LoadMoreWidget2<Conversation>(
                  onLoadData: (page) async {
                    var response = await chatBloc.tryFetchListConversation(page);
                    return PageData(
                        code: response?.code,
                        message: response?.message,
                        data: response?.data);
                  },
                  countReload: countReload,
                  itemBuilder: (item)=> ConversationItem(conversation: item),
                  reloadRefresh: (){
                    countReload++;
                    this.chatBloc.add(LoadListConversationChanged());
                  },
                  itemNoData: const Center(
                    child: Text(
                        "You have not conversation!"
                    ),
                  )
              )
          );
        }
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



  /**
   * method wantKeepAlive to keep state when slide among Tabviews
   */
  @override
  bool get wantKeepAlive => true;
}
