
import 'package:facebook_auth/blocs/verify_code/verify_code_event.dart';
import 'package:facebook_auth/blocs/verify_code/verify_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:formz/formz.dart';

import '../../data/repository/authen_repository.dart';

class VerifyCodeBloc extends Bloc<VerifyCodeEvent,VerifyCodeState>{

  final AuthenRepository _authenRepository;
  final String phone;
  String verifyCode;
  VerifyCodeBloc(this._authenRepository, this.phone, this.verifyCode): super(VerifyCodeState()) {
    delayScreen();
    delayDialogFirst();
    on<GetVerifyCodeChanged>(_getVerifyCode);
    on<CheckVerifyCodeChanged>(checkVerifyCode);

  }

  Future<void> _getVerifyCode(
      GetVerifyCodeChanged event,
      Emitter<VerifyCodeState> emit,
      ) async{
      emit(state.copyWidth(statusGetCode: FormzStatus.submissionInProgress));
      final responeVerifyCode = await _authenRepository.getVerifyCode(this.phone);
      if(responeVerifyCode!= null){
        this.verifyCode = responeVerifyCode.data!.verifyCode!;
        emit(state.copyWidth(statusGetCode: FormzStatus.submissionSuccess));
        emit(state.copyWidth(statusDialog: FormzStatus.submissionSuccess,verifyCode: this.verifyCode));
      }else{
        emit(state.copyWidth(statusGetCode: FormzStatus.submissionFailure));
      }

  }

  Future<void> checkVerifyCode(
      CheckVerifyCodeChanged event,
      Emitter<VerifyCodeState> emit,
      ) async{
    emit(state.copyWidth(statusCheckCode: FormzStatus.submissionInProgress));
    final responeVerifyCode = await _authenRepository.checkVerifyCode(this.phone,event.code);
    final storage = new FlutterSecureStorage();
    if(responeVerifyCode!= null){
      await storage.write(key: "token", value: responeVerifyCode.data!.token);
      emit(state.copyWidth(statusCheckCode: FormzStatus.submissionSuccess));
    }else{
      emit(state.copyWidth(statusCheckCode: FormzStatus.submissionFailure));
    }
  }

  Future<void> delayScreen() async{
    await Future.delayed(Duration(seconds: 2));
    emit(state.copyWidth(statusSlide: FormzStatus.pure));
  }
  Future<void> delayDialogFirst() async{
    await Future.delayed(Duration(milliseconds: 1500));
    emit(state.copyWidth(statusDialog: FormzStatus.submissionSuccess,verifyCode: this.verifyCode));
  }

}