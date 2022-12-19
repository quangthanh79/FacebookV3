


import 'package:facebook_auth/data/models/chat.dart';
import 'package:facebook_auth/data/models/chat_detail.dart';
import 'package:facebook_auth/data/models/page_data.dart';
import 'package:facebook_auth/data/repository/chat_repository.dart';
import 'package:facebook_auth/icon/camera_icons.dart';
import 'package:facebook_auth/icon/info_icons.dart';
import 'package:facebook_auth/icon/image_icons.dart';
import 'package:facebook_auth/icon/menu_icons.dart';
import 'package:facebook_auth/icon/mic_icons.dart';
import 'package:facebook_auth/icon/person_icons.dart';
import 'package:facebook_auth/icon/photo_icons.dart';
import 'package:facebook_auth/icon/send_icons.dart';
import 'package:facebook_auth/icon/smile_icons.dart';
import 'package:facebook_auth/icon/video_icons.dart';
import 'package:facebook_auth/screen/chat_screen/blocs/chat_blocs/chat_state.dart';
import 'package:facebook_auth/screen/chat_screen/blocs/chat_detail_blocs/chat_detail_bloc.dart';
import 'package:facebook_auth/screen/chat_screen/blocs/chat_detail_blocs/chat_detail_event.dart';
import 'package:facebook_auth/screen/chat_screen/blocs/chat_detail_blocs/chat_detail_state.dart';
import 'package:facebook_auth/screen/chat_screen/message_item/message_item.dart';
import 'package:facebook_auth/screen/chat_screen/message_item/message_partner_item.dart';
import 'package:facebook_auth/screen/chat_screen/message_item/message_partner_item_impl.dart';

import 'package:facebook_auth/utils/app_theme.dart';
import 'package:facebook_auth/utils/image.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:facebook_auth/utils/widget/load_more_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lottie/lottie.dart';

import '../../icon/phone_icons.dart';

class ChatDetailScreen extends StatefulWidget{
  final Partner partner;
  ChatDetailScreen({
    required this.partner,
  });
  static Route<void> route(Partner partner) {
    return PageRouteBuilder(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, _, __) {
          return new ChatDetailScreen(partner: partner);
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new SlideTransition(
            child: child,
            position: new Tween<Offset>(
              begin: Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
          );
        }
    );
  }

  @override
  ChatDetailScreenState createState() => ChatDetailScreenState();
}
class ChatDetailScreenState extends State<ChatDetailScreen> with WidgetsBindingObserver{
  final chatDetailBloc = ChatDetailBloc(getIt.get<ChatRepository>());
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    return BlocProvider(
        create: (context) {
          return chatDetailBloc;
        },
        child: BlocListener<ChatDetailBloc,ChatDetailState>(
          listener: (context,state){
            switch(state.statusHasMessgage){
              case StatusHasMessgage.SendMessage:
                print("COMPARE SHOW SNACK BAR");
                SnackBar snackBar = SnackBar(
                  content: Text(state.message?.message ?? "Tin nhắn mới"),
                  duration: Duration(seconds: 1),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentMaterialBanner()
                  ..showSnackBar(snackBar);


                break;
              case StatusHasMessgage.ReceiveMessage:
                if(WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed){
                  // call API set read message
                  this.chatDetailBloc.add(BindingResumeChanged(widget.partner.id ?? ""));
                }
                print("Bạn vừa nhận được tin nắn mới");
                break;
            }


          },
          child: BlocBuilder<ChatDetailBloc,ChatDetailState>(
            builder: (context,state){
              return GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Scaffold(
                    backgroundColor: Colors.white,
                    resizeToAvoidBottomInset: true,
                    body: Container(
                      color: Colors.white,
                      child: SafeArea(
                          top: true,
                          bottom: true,
                          child: Column(
                            children: [
                              getTabBar(context),
                              LoadMoreWidget<MessageDetail>(
                                  onLoadData: (page) async {
                                    var response = await chatDetailBloc.getDetailConversation(widget.partner.id!);
                                    return PageData(
                                        code: response?.code,
                                        message: response?.message,
                                        indexMessageLast: response?.indexMessageLast,
                                        data: response?.data?.reversed.toList());
                                  },
                                  addMessage: state.message,
                                  countReload: state.countMessage,
                                  itemBuilder: (item,itemPrevious,itemNext,index,dataLength){
                                    if(dataLength == 1){
                                      if(item.sender!.id! != SessionUser.idUser){
                                        return MessagePartnerItemTypeImpl(messageDetail: item,itemType: ItemType.SINGLE);
                                      }
                                    }
                                    if(item.sender!.id! == SessionUser.idUser){
                                      return MessageItem(messageDetail: item);
                                    }else{
                                      if(index == 0){
                                        if(itemNext?.sender!.id! == SessionUser.idUser){
                                          return MessagePartnerItemTypeImpl(messageDetail: item,itemType: ItemType.SINGLE);
                                        }else{
                                          return MessagePartnerItemTypeImpl(messageDetail: item,itemType: ItemType.BOTTOM);
                                        }
                                      }
                                      else if(index == dataLength - 1){
                                        if(itemPrevious?.sender!.id! != SessionUser.idUser){
                                          return MessagePartnerItemTypeImpl(messageDetail: item,itemType: ItemType.TOP);
                                        }else{
                                          return MessagePartnerItemTypeImpl(messageDetail: item,itemType: ItemType.SINGLE);
                                        }
                                      } else {
                                        if(
                                        itemNext?.sender!.id! != SessionUser.idUser &&
                                            itemPrevious?.sender!.id! != SessionUser.idUser
                                        ){
                                          return MessagePartnerItemTypeImpl(messageDetail: item,itemType: ItemType.MIDDLE);
                                        }
                                        if(
                                        itemNext?.sender!.id! == SessionUser.idUser &&
                                            itemPrevious?.sender!.id! != SessionUser.idUser
                                        ){
                                          return MessagePartnerItemTypeImpl(messageDetail: item,itemType: ItemType.TOP);
                                        }
                                        if(
                                        itemNext?.sender!.id! != SessionUser.idUser &&
                                            itemPrevious?.sender!.id! == SessionUser.idUser
                                        ){
                                          return MessagePartnerItemTypeImpl(messageDetail: item,itemType: ItemType.BOTTOM);
                                        }
                                        if(
                                        itemNext?.sender!.id! != SessionUser.idUser &&
                                            itemPrevious?.sender!.id! == SessionUser.idUser
                                        ){
                                          return MessagePartnerItemTypeImpl(messageDetail: item,itemType: ItemType.MIDDLE);
                                        }
                                        return MessagePartnerItemTypeImpl(messageDetail: item,itemType: ItemType.SINGLE);
                                      }
                                    }

                                  }),
                              getTextField(context)
                            ],
                          )
                      ),
                    )
                ),
              );
            },
          ),

        )
    );
  }
  Widget getTabBar(BuildContext context){
    return Material(
        elevation: 2.0,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 2),
          child: Row(
            children: [
              SizedBox(width: 5),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                splashRadius: 20,
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppTheme.primaryPink,
                  size: 25,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: getImage(
                  uri: widget.partner.avatar ?? 'assets/images/default_avatar_image.jpg',
                  defaultUri: 'assets/images/default_avatar_image.jpg',
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(width: 2,),
              Expanded(
                  child: Text(
                    widget.partner.username != null ? widget.partner.username! : "Người dùng facobook",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  )
              ),
              IconButton(
                onPressed: () {
                  print("Go to CALL");
                },
                splashRadius: 20,
                icon: const Icon(
                  Phone.phone,
                  color: AppTheme.primaryPink,
                  size: 18,
                ),
              ),
              SizedBox(width: 2),
              IconButton(
                onPressed: () {
                  print("Go to VIDEO CALL");
                },
                splashRadius: 20,
                icon: const Icon(
                  Video.video,
                  color: AppTheme.primaryPink,
                  size: 25,
                ),
              ),
              SizedBox(width: 2),
              IconButton(
                onPressed: () {
                  print("Go to VIDEO CALL");
                },
                splashRadius: 20,
                icon: const Icon(
                  Info.info,
                  color: AppTheme.primaryPink,
                  size: 20,
                ),
              ),
              SizedBox(width: 6)
            ],
          ),
        )
    );
  }
  Widget getTextField(BuildContext context){
    return BlocBuilder<ChatDetailBloc,ChatDetailState>(
        builder: (context,state){
          return Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                child: Row(
                  children: [
                    Visibility(
                      child: Expanded(
                          flex: 2,
                          child: Center(
                            child: InkWell(
                              onTap: (){},
                              child: Icon(
                                Menu.menu,
                                color: AppTheme.primaryPurple,
                                size: 18,
                              ),
                            ),
                          )
                      ),
                      visible: state.statusWidthInput == WidthInput.OVERAGE ? false : true,
                    ),
                    Visibility(
                      child: Expanded(
                          flex: state.statusWidthInput == WidthInput.OVERAGE ? 0: 2,
                          child: Center(
                            child: InkWell(
                              onTap: (){},
                              child: const Icon(
                                Camera.photo_camera,
                                color: AppTheme.primaryPurple,
                                size: 25,
                              ),
                            ),
                          )
                      ),
                      visible: state.statusWidthInput == WidthInput.OVERAGE ? false : true,
                    ),
                    Visibility(
                      child: Expanded(
                          flex: state.statusWidthInput == WidthInput.OVERAGE ? 0: 2,
                          child: Center(
                            child: InkWell(
                              onTap: (){},
                              child: const Icon(
                                Photo.photo,
                                color: AppTheme.primaryPurple,
                                size: 22,
                              ),
                            ),
                          )
                      ),
                      visible: state.statusWidthInput == WidthInput.OVERAGE ? false : true,
                    ),
                    Visibility(
                      child: Expanded(
                          flex: state.statusWidthInput == WidthInput.OVERAGE ? 0: 2,
                          child: Center(
                            child: InkWell(
                              onTap: (){},
                              child: const Icon(
                                Mic.mic,
                                color: AppTheme.primaryPurple,
                                size: 20,
                              ),
                            ),
                          )
                      ),
                      visible: state.statusWidthInput == WidthInput.OVERAGE ? false : true,
                    ),
                    Visibility(
                      child: SizedBox(width: 10),
                      visible: state.statusWidthInput == WidthInput.OVERAGE ? true : false,
                    ),
                    Visibility(
                      child: Expanded(
                          flex: state.statusWidthInput == WidthInput.OVERAGE ? 0: 4,
                          child: Center(
                            child: InkWell(
                              onTap: (){},
                              child: const Icon(
                                Icons.chevron_right,
                                color: AppTheme.primaryPurple,
                                size: 30,
                              ),
                            ),
                          )
                      ),
                      visible: state.statusWidthInput == WidthInput.OVERAGE ? true : false,
                    ),
                    Visibility(
                      child: SizedBox(width: 10),
                      visible: state.statusWidthInput == WidthInput.OVERAGE ? true : false,
                    ),



                    Expanded(
                        flex: 8,
                        child: Focus(
                          child: TextField(
                            showCursor: true,
                            cursorColor: AppTheme.primary,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            controller: _controller,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(width: 0.5,color: Color(0xFFF2F3F5)),
                              ),
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(width: 0.5,)
                              ),
                              filled: true,
                              suffixIcon: IconButton(
                                icon:  const Icon(
                                  Smile.smile,
                                  color: AppTheme.primaryPurple,
                                  size: 20,
                                ),
                                onPressed: () {
                                  print("OKKKK");
                                  // _controller.clear();
                                  // listRoomBloc.add(RoomLoadDataChanged(widget.houseId,""));
                                  // listRoomBloc.add(RoomClearSearchChanged());
                                },
                              ),
                              fillColor: Color(0xFFF2F3F5),
                              hintStyle: TextStyle(color: Color(0xFF666666), fontSize: 16),
                              hintText: "Nhắn tin",
                              isDense: true,
                              contentPadding: EdgeInsets.all(6),
                            ),
                            onChanged: (content) {

                            },
                            style: TextStyle(fontSize: 16),
                          ),
                          onFocusChange: (hasFocus) {
                            if(hasFocus){
                              context.read<ChatDetailBloc>().add(WidthInputChanged(WidthInput.OVERAGE));
                              print("FOCUS");
                            }else{
                              context.read<ChatDetailBloc>().add(WidthInputChanged(WidthInput.SHRINK));
                              print("UNfocus");
                            }
                          },
                        )
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: (){
                        print("TEXT: "+ _controller.text);
                        if(_controller.text.length !=0 ){
                          context.read<ChatDetailBloc>().add(SendMessageChanged(_controller.text,widget.partner.id ?? ""));
                        }
                        _controller.clear();
                      },
                      child: const Icon(
                        Send.send,
                        color: AppTheme.primaryPurple,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              )
          );
        }
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // call API set rea message;
        this.chatDetailBloc.add(BindingResumeChanged(widget.partner.id ?? ""));
        print("app in resumed");
        break;
    }
    print("THAY DOI Lifecycle");
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
}

