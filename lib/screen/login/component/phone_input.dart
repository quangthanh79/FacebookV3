

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/sign_in/models/phone.dart';
import '../../../blocs/sign_in/sign_in_bloc.dart';
import '../../../blocs/sign_in/sign_in_event.dart';
import '../../../blocs/sign_in/sign_in_state.dart';

class PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SignInBloc,SignInState>(
        builder: (context,state){

          String? errorText;
          if (state.phone.invalid) {
            switch (state.phone.error) {
              case null:
                errorText = null;
                break;
              case PhoneValidationError.empty:
                errorText = "Vui lòng nhập số di động";
                break;
              case PhoneValidationError.wrongFormat:
                errorText = "Số di động sai định dạng";
                break;
            }
          } else {
            errorText = null;
          }
          return Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
              child: TextField(
                textInputAction: TextInputAction.next,
                onChanged: (text){
                  context.read<SignInBloc>().add(SignInPhoneChanged(text));
                },
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration:  InputDecoration(
                  hintText: "Số điện thoại hoặc email",
                  errorText: errorText,
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)
                  ),
                  labelStyle: TextStyle(color: Color(0xff888888), fontSize: 15),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                ),
                // onChanged: (str) => value.email = str,
              )

          );
        }

    );
  }

}

