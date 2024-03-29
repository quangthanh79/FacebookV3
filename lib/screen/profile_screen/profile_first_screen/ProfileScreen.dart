import 'package:facebook_auth/data/datasource/remote/profile_api_provider.dart';
import 'package:facebook_auth/blocs/sign_out/sign_out_bloc.dart';
import 'package:facebook_auth/blocs/sign_out/sign_out_event.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/profile_repository.dart';
import 'package:facebook_auth/icon/setting_icons.dart';
import 'package:facebook_auth/screen/friend_screen/friend_list_screen/friend_list_screen.dart';
import 'package:facebook_auth/screen/login/login_screen.dart';
import 'package:facebook_auth/screen/main_facebook.dart';
import 'package:facebook_auth/screen/profile_screen/block_screen/ListBlockScreen.dart';
import 'package:facebook_auth/screen/profile_screen/PrivacyScreen.dart';
import 'package:facebook_auth/screen/profile_screen/profile_first_screen/ExpandedTagProfile.dart';
import 'package:facebook_auth/screen/profile_screen/TermsOfServiceScreen.dart';
import 'package:facebook_auth/screen/signup/set_info_after_signup.dart';
import 'package:facebook_auth/screen/profile_screen/profile_first_screen/TagProfileNew.dart';
import 'package:facebook_auth/utils/Progress_Dialog.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:formz/formz.dart';

import '../../../blocs/sign_out/sign_out_state.dart';
import '../../../data/datasource/local/flutter_secure_storage.dart';
import '../../../icon/loupe_icons.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/image.dart';
import '../../search_screen/search_screen.dart';
import '../../user_screen/user_screen.dart';
import '../change_password_screen/change_password_screen.dart';
import 'TagProfile.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: 15.0,
            top: 60.0,
          ),
          child: Row(
            children: <Widget>[
              Text("Menu",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Expanded(child: SizedBox()),
              Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Container(
                    height: 36,
                    width: 36,
                    child: Icon(
                      Setting.settings,
                      size: 17,
                    ),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppTheme.grey200),
                  )),

              GestureDetector(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(key)));
                  showSearch(
                      context: context,
                      delegate: MyCustomDelegate()
                  );
                },
                child: Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Container(
                      height: 36,
                      width: 36,
                      child: Icon(
                        Loupe.loupe,
                        size: 17,
                      ),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppTheme.grey200),
                    )
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 15, top: 10, bottom: 8.0),
            child: GestureDetector(
              child: Row(
                children: <Widget>[
                  // CircleAvatar(
                  //   radius: 20.0,
                  //   backgroundColor: Colors.white,
                  //   backgroundImage: AssetImage("assets/images/avatarDefault.png"),
                  // ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: getImage(
                      uri: SessionUser.user?.avatar ?? 'assets/images/default_avatar_image.jpg',
                      defaultUri: 'assets/images/default_avatar_image.jpg',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                            SessionUser.user?.username ?? "Người dùng facebook",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 5.0),
                        child: Text("Xem trang cá nhân của bạn", style: TextStyle(fontSize: 16.0),),
                      )
                    ],
                  )
                ],
              ),
              onTap: () {
                User user = SessionUser.user ?? User();
                // Navigate to UserScreen
                Navigator.push(
                    context,
                    UserScreen.route(
                        user: user
                    )
                );
              },
            )),

        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("Tất cả lối tắt",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ),


        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            children: <Widget>[
              TagProfileNew(key, "Kỷ niệm", "assets/images/ic_memory.png"),
              TagProfileNew(key, "Bảng feed", "assets/images/ic_feed.png"),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        FriendListScreen.route(
                            user: SessionUser.user!,
                            onBack: (){}
                        )
                    );
                  },
                  child: TagProfileNew(key, "Bạn bè", "assets/images/ic_friend_fb.png"),
                )
              ),
              TagProfileNew(key, "Nhóm", "assets/images/ic_group.png"),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            children: <Widget>[
              TagProfileNew(key, "Marketplace", "assets/images/ic_market_place.png"),
              TagProfileNew(key, "Video trên watch", "assets/images/ic_video_watch.png"),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            children: <Widget>[
              TagProfileNew(key, "Đã lưu", "assets/images/ic_save.png"),
              TagProfileNew(key, "Trang", "assets/images/ic_page.png"),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            children: <Widget>[
              TagProfileNew(key, "Reels", "assets/images/ic_reels.png"),
              TagProfileNew(key, "Hẹn hò", "assets/images/ic_love.png"),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 32),
          child: Row(
            children: <Widget>[
              TagProfileNew(key, "Sự kiện", "assets/images/ic_event.png"),
              TagProfileNew(key, "Chơi game", "assets/images/ic_game.png"),
            ],
          ),
        ),
        Container(
            decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
            child: ExpansionTile(
              // textColor: Colors.black,
              title: Text("Trợ giúp & hỗ trợ"),
              leading: Icon(Icons.help_outlined),
              children: [
                ListTile(
                  title: ExpandedTagProfile(
                      key, "Điều khoản dịch vụ", Icon(Icons.book)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TermsOfServiceScreen(key)));
                  },
                ),
                ListTile(
                  title: ExpandedTagProfile(
                      key, "Chính sách quyền riêng tư", Icon(Icons.lock)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacyScreen(key)));
                  },
                ),
              ],
            )),
        Container(
            decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(color: Colors.grey, width: 0.5))),
            child: ExpansionTile(
              title: Text("Cài đặt thông báo đẩy"),
              leading: Icon(Icons.notifications_active),
              children: [
                ListTile(
                  title: ExpandedTagProfile(
                      key, "Bật/tắt thông báo", Icon(Icons.toggle_on_rounded)),
                ),
              ],
            )),
        Container(
          decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
          child: ExpansionTile(
            title: Text("Cài đặt & quyền riêng tư"),
            leading: Icon(Setting.settings),
            children: [
              ListTile(
                title: ExpandedTagProfile(
                  key, "Danh sách chặn", Icon(Icons.no_accounts),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListBlockScreen(key)));
                },
              ),
              ListTile(
                title: ExpandedTagProfile(
                  key, "Đổi mật khẩu", Icon(Icons.lock_reset_outlined)
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen(key)));
                },
              )
            ],
          ),
        ),


        BlocProvider(
            create: (context) => SignOutBloc(getIt.get<ProfileRepository>()),
            child: BlocListener<SignOutBloc, SignOutState>(
                listener: (context, state) {
                  switch (state.statusSignOut) {
                    case FormzStatus.submissionInProgress:
                      progressDialog.showProgress();
                      break;
                    case FormzStatus.submissionSuccess:
                      progressDialog.hideProgress();
                      const SnackBar snackBar = SnackBar(
                        content: Text("Đăng xuất thành công"),
                        duration: Duration(seconds: 1),
                      );
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginScreen()),
                          (route) => false);
                      ScaffoldMessenger.of(context)
                        ..hideCurrentMaterialBanner()
                        ..showSnackBar(snackBar);
                      MainFacebookScreenState temp = MainFacebookScreenState();
                      temp.tabIconsList[0].isSelected = true;
                      temp.tabIconsList[temp.tabIconsList.length - 1].isSelected = false;
                      break;
                    case FormzStatus.submissionFailure:
                      progressDialog.hideProgress();
                      const SnackBar snackBar = SnackBar(
                        content: Text("Đã có lỗi xảy ra!"),
                        duration: Duration(seconds: 1),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentMaterialBanner()
                        ..showSnackBar(snackBar);
                      break;
                  }
                }, child: Builder(
                  builder: (BuildContext newContext) {
                    return Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: AppTheme.grey200),
                            child: Text(
                              "Đăng xuất",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.black),
                            ),
                            onPressed: () {
                              newContext.read<SignOutBloc>().add(SignOutEvent());
                            },
                          ),
                    ));
                  },
            ))),
      ],
    );
  }
}
