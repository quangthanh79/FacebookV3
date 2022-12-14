import 'package:facebook_auth/screen/main_facebook.dart';
import 'package:facebook_auth/utils/context_ext.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:facebook_auth/utils/widget/appbar_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../blocs/verify_code/verify_code_bloc.dart';
import '../../blocs/verify_code/verify_code_event.dart';
import '../../blocs/verify_code/verify_code_state.dart';
import '../../data/repository/authen_repository.dart';
import '../../utils/Button.dart';
import '../../utils/Progress_Dialog.dart';
import '../../utils/app_theme.dart';

class ConfirmAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    final phone = argument["phone"] as String;
    final verifyCode = argument["verifyCode"] as String;
    final _controller = TextEditingController();

    return BlocProvider(
        create: (context) {
          return VerifyCodeBloc(getIt.get<AuthenRepository>(), phone, verifyCode);
        },
        child: BlocListener<VerifyCodeBloc, VerifyCodeState>(
            listener: (context, state) {
          if (state.statusDialog.isSubmissionSuccess) {
            navigatorKey.currentContext!.showVerifyCode(state.verifyCode);
          }
          switch (state.statusCheckCode) {
            case FormzStatus.submissionSuccess:
              progressDialog.hideProgress();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainFacebookScreen(),
                  ),
                  (Route<dynamic> route) => false);
              break;
            case FormzStatus.submissionInProgress:
              progressDialog.showProgress();
              break;
            case FormzStatus.submissionFailure:
              progressDialog.hideProgress();
              const SnackBar snackBar = SnackBar(
                content: Text('Mã xác thực không chính xác!'),
                duration: Duration(seconds: 1),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentMaterialBanner()
                ..showSnackBar(snackBar);
          }
          switch (state.statusGetCode) {
            case FormzStatus.submissionFailure:
              progressDialog.hideProgress();
              const SnackBar snackBar = SnackBar(
                content: Text('Đã có lỗi xảy ra'),
                duration: Duration(seconds: 1),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentMaterialBanner()
                ..showSnackBar(snackBar);
              break;
            case FormzStatus.submissionInProgress:
              progressDialog.showProgress();
              break;
            case FormzStatus.submissionSuccess:
              progressDialog.hideProgress();
              break;
          }
        }, child: BlocBuilder<VerifyCodeBloc, VerifyCodeState>(
          builder: (context, state) {
            return Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                    top: true,
                    child: Center(
                        child: Column(children: [
                      getAppBar(context, "Xác nhận tài khoản"),
                      SizedBox(
                        height: 80,
                      ),
                      Row(
                        children: [
                          Expanded(child: SizedBox()),
                          const Text("Chúng tôi đã gửi SMS kèm mã tới ",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              )),
                          Text(phone,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      const Text("Nhập mã gồm 4 chữ số từ SMS của bạn",
                          style: TextStyle(
                            color: AppTheme.grey800,
                            fontFamily: 'OpenSans',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(child: SizedBox()),
                          const Text("FB-",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 120,
                            child: TextField(
                              showCursor: true,
                              controller: _controller,
                              cursorColor: AppTheme.primary,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 2, color: AppTheme.grey800),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10.0),
                              ),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                      SizedBox(height: 25),
                      Button.buildButtonPrimary(context, "Xác nhận", () {
                        context
                            .read<VerifyCodeBloc>()
                            .add(CheckVerifyCodeChanged(_controller.text));
                      }),
                      SizedBox(height: 25),
                      Button.buildButtonGrey(context, "Tôi không nhận được mã",
                          () {
                        context
                            .read<VerifyCodeBloc>()
                            .add(GetVerifyCodeChanged());
                      })
                    ]))));
          },
        )));
  }
}
