

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../blocs/sign_in/sign_in_bloc.dart';
import '../../../blocs/sign_in/sign_in_event.dart';
import '../../../blocs/sign_in/sign_in_state.dart';
import '../../../utils/app_theme.dart';

class ButtonSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SignInBloc,SignInState>(
        builder: (context,state){
          return Padding(
              padding: const EdgeInsets.fromLTRB(30, 8, 30, 0),
              child: SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: MaterialButton(
                    onPressed: state.status.isValid?
                        () {
                      context.read<SignInBloc>().add(SignInSubmit());
                    } : (){},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all((Radius.circular(4)))),
                    color: AppTheme.primary,
                    child: buildLoginChild(),
                  )
              ));
        });
  }
  Widget buildLoginChild() {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        'Đăng nhập',
        maxLines: 1,
        textAlign: TextAlign.center,
        overflow: TextOverflow.fade,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.white),
      ),
    );
  }
}

