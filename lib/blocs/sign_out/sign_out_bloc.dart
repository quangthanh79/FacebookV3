import 'package:facebook_auth/core/helper/cache_helper.dart';
import 'package:facebook_auth/data/models/post_response.dart';
import 'package:facebook_auth/blocs/sign_out/sign_out_event.dart';
import 'package:facebook_auth/blocs/sign_out/sign_out_state.dart';
import 'package:facebook_auth/data/repository/profile_repository.dart';
import 'package:facebook_auth/utils/constant.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  final ProfileRepository _profileRepository;

  SignOutBloc(this._profileRepository) : super(SignOutState()) {
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onSignOut(
      SignOutEvent event, Emitter<SignOutState> emitter) async {
    emitter(state.copyWith(status: FormzStatus.submissionInProgress));
    Optional response = await _profileRepository.logout();
    if (response == Optional.success) {
      getIt<CacheHelper>().setListPost(PostListResponse());
      emitter(state.copyWith(status: FormzStatus.submissionSuccess));
    } else {
      emitter(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
