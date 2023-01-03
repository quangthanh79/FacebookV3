
import 'package:facebook_auth/blocs/change_password/change_password_bloc.dart';
import 'package:facebook_auth/blocs/change_password/change_password_event.dart';
import 'package:facebook_auth/blocs/change_password/change_password_state.dart';
import 'package:facebook_auth/data/repository/profile_repository.dart';
import 'package:facebook_auth/utils/Progress_Dialog.dart';
import 'package:facebook_auth/utils/app_theme.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasource/local/flutter_secure_storage.dart';
import '../../main_facebook.dart';
import 'SuccessChangeScreen.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen(Key? key) : super(key: key);

  static String curPass = "", reNewPass = "", newPass = "";
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          key: key,
          elevation: 1.0,
          centerTitle: false,
          backgroundColor: Colors.white,
          title: Text("Đổi mật khẩu", style: TextStyle(color: Colors.black,),),
          leading: GestureDetector(
            child: Icon(Icons.arrow_back, color: Colors.black,),
            onTap: () {
              Navigator.pop(context);
            },
          )
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  height: 50.0,
                  child: TextField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    onChanged: (text){
                      curPass = text;
                    },
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Mật khẩu hiện tại",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.4, color: Colors.grey),
                      ),
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.black,),
                    ),
                  ),
                ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: SizedBox(
                height: 50.0,
                child: TextField(
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  onChanged: (text){
                    newPass = text;
                  },
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Mật khẩu mới",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.4, color: Colors.grey),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                    ),
                    prefixIcon: Icon(Icons.key_outlined, color: Colors.black,),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: SizedBox(
                height: 50.0,
                child: TextField(
                  obscureText: true,
                  onChanged: (text){
                    reNewPass = text;
                  },
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Nhập lại mật khẩu mới",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.4, color: Colors.grey),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                    ),
                    prefixIcon: Icon(Icons.key_outlined, color: Colors.black,),
                  ),
                ),
              ),
            ),

            BlocProvider(
                create: (context) => ChangePasswordBloc(getIt.get<ProfileRepository>()),
                child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
                  listener: (context, state){
                    switch(state.changePasswordStatus){
                      case ChangePasswordStatus.CORRECT:
                        progressDialog.hideProgress();
                        const SnackBar snackBar = SnackBar(
                          content: Text("Cập nhật mật khẩu thành công"),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentMaterialBanner()
                          ..showSnackBar(snackBar);
                        SecureStorage.instance.clearUserData();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuccessChangeScreen(key, context),
                            ));
                        MainFacebookScreenState temp = MainFacebookScreenState();
                        temp.tabIconsList[0].isSelected = true;
                        temp.tabIconsList[temp.tabIconsList.length - 1].isSelected = false;
                        break;
                      case ChangePasswordStatus.INCORRECT:
                        progressDialog.hideProgress();
                        const SnackBar snackBar = SnackBar(
                          content: Text("Mật khẩu hiện tại không đúng"),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentMaterialBanner()
                          ..showSnackBar(snackBar);
                        break;
                      case ChangePasswordStatus.COMMON:
                        progressDialog.hideProgress();
                        const SnackBar snackBar = SnackBar(
                          content: Text("Mật khẩu cũ trùng với mật khẩu mới"),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentMaterialBanner()
                          ..showSnackBar(snackBar);
                        break;
                      case ChangePasswordStatus.COMMON_MORE_80:
                        progressDialog.hideProgress();
                        const SnackBar snackBar = SnackBar(
                          content: Text("Mật khẩu mới bị trùng hơn 80% mật khẩu cũ"),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentMaterialBanner()
                          ..showSnackBar(snackBar);
                        break;
                      case ChangePasswordStatus.IN_PROGRESS:
                        progressDialog.showProgress();
                    }
                  },
                  child: Builder(
                    builder: (BuildContext newContext){
                      return Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child:
                          MaterialButton(
                            textColor: Colors.white,
                            color: AppTheme.primary,
                            child: Text("Cập nhật mật khẩu", style: TextStyle(fontSize: 18.0),),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all((Radius.circular(6)))),
                            onPressed: (){
                                if(curPass.isEmpty){
                                  const SnackBar snackBar = SnackBar(
                                    content: Text("Mật khẩu hiện tại trống"),
                                    duration: Duration(seconds: 2),
                                  );
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentMaterialBanner()
                                    ..showSnackBar(snackBar);
                                } else if(newPass.isEmpty){
                                  const SnackBar snackBar = SnackBar(
                                    content: Text("Mật khẩu mới trống"),
                                    duration: Duration(seconds: 2),
                                  );
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentMaterialBanner()
                                    ..showSnackBar(snackBar);
                                } else if(reNewPass != newPass){
                                  const SnackBar snackBar = SnackBar(
                                    content: Text("Mật khẩu không trùng khớp"),
                                    duration: Duration(seconds: 2),
                                  );
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentMaterialBanner()
                                    ..showSnackBar(snackBar);
                                } else{
                                  newContext.read<ChangePasswordBloc>().add(ChangePasswordEvent(curPass: curPass, newPass: newPass));
                                }
                            },
                          ),
                        );
                    },
                  ),
                ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 0.0),
              child:
              MaterialButton(
                textColor: Colors.black,
                color: AppTheme.grey200,
                elevation: 0.5,
                child: Text("Hủy", style: TextStyle(fontSize: 18.0),),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all((Radius.circular(6)))),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              //   TextButton(
              //
              //   )
            ),
          ],
        ),
      )
    );
  }

}