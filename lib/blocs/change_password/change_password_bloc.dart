

import 'package:facebook_auth/data/models/change_password_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/profile_repository.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState>{
  ProfileRepository _profileRepository;
  
  ChangePasswordBloc(this._profileRepository) : super(ChangePasswordState()){
    on<ChangePasswordEvent>(_changPassword);
  }
  
  Future<void> _changPassword(ChangePasswordEvent event, Emitter<ChangePasswordState> emitter) async {
    emitter(state.copywith(ChangePasswordStatus.IN_PROGRESS));

    ChangePasswordResponse? response = await _profileRepository.changePassword(event.curPass, event.newPass);
    if(response != null){
      if(response.message == "OK"){
        emitter(state.copywith(ChangePasswordStatus.CORRECT));
      } else if(response.details == "password khong dung"){
        emitter(state.copywith(ChangePasswordStatus.INCORRECT));
      } else if(response.details == "new_password == password"){
        emitter(state.copywith(ChangePasswordStatus.COMMON));
      }else {
        emitter(state.copywith(ChangePasswordStatus.COMMON_MORE_80));
      }
    }
  }

}