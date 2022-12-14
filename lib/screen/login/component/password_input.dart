

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/sign_in/models/password.dart';
import '../../../blocs/sign_in/models/phone.dart';
import '../../../blocs/sign_in/sign_in_bloc.dart';
import '../../../blocs/sign_in/sign_in_event.dart';
import '../../../blocs/sign_in/sign_in_state.dart';
import '../../../icon/hide_icons.dart';

class PasswordInput extends StatelessWidget {
  bool _checkHideIcon = true;
  bool _checkSecure = true;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SignInBloc,SignInState>(
        builder: (context,state){
          String? errorText;
          if (state.password.invalid) {
            switch (state.password.error) {
              case null:
                errorText = null;
                break;
              case PasswordValidationError.empty:
                errorText = "Vui lòng nhập mật khẩu";
                break;
              case PasswordValidationError.inValidLength:
                errorText = "Mật khẩu tối thiểu 6 ký tự";
                break;
            }
          } else {
            errorText = null;
          }
          return Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
              child: TextField(
                onChanged: (text) {
                  context.read<SignInBloc>().add(SignInPasswordChanged(text));
                },
                style: TextStyle(fontSize: 18, color: Colors.black),
                // obscureText: !_showPass,
                decoration: InputDecoration(
                  hintText: "Mật khẩu",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)
                  ),
                  labelStyle: TextStyle(color: Color(0xff888888), fontSize: 15),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                  errorText: errorText,
                  suffixIcon: _checkHideIcon ? null: IconButton(
                    icon: Icon(
                      _checkSecure? Hide.hidden : Icons.remove_red_eye,
                      color: Color(0xFF666666),
                      size: 18,
                    ),
                    onPressed: (){

                    },
                  ),
                ),
                obscureText: _checkSecure,
              )
          );
        }
    );
  }

}

