
import 'package:facebook_auth/data/models/response_sign_out.dart';
import 'package:facebook_auth/blocs/sign_out/sign_out_event.dart';
import 'package:facebook_auth/blocs/sign_out/sign_out_state.dart';
import 'package:facebook_auth/data/repository/profile_repository.dart';
import 'package:facebook_auth/utils/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:formz/formz.dart';

import '../../data/datasource/remote/profile_api_provider.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutState>{
  final ProfileRepository _profileRepository;

  SignOutBloc(this._profileRepository) : super(SignOutState()){
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<SignOutState> emitter) async{
    emitter(state.copyWith(status: FormzStatus.submissionInProgress));
    Optional response = await _profileRepository.logout();
    if(response == Optional.success){
      emitter(state.copyWith(status: FormzStatus.submissionSuccess));
    } else{
      emitter(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

}