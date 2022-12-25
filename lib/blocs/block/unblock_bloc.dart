

import 'package:facebook_auth/blocs/block/BlockApiProvider.dart';
import 'package:facebook_auth/blocs/block/BlockModel.dart';
import 'package:facebook_auth/blocs/block/block_event.dart';
import 'package:facebook_auth/blocs/block/block_state.dart';
import 'package:facebook_auth/blocs/block/unblock_state.dart';
import 'package:facebook_auth/data/models/unblock_response.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class UnBlockBloc extends Bloc<BlockEvent, UnBlockState>{
  final BlockApiProvider _blockApiProvider;

  UnBlockBloc(this._blockApiProvider) : super(UnBlockState()) {
    on<SetUnBlockEvent>(_onSetUnBlock);
  }

  Future<void> _onSetUnBlock(SetUnBlockEvent event, Emitter<UnBlockState> emitter) async{
    emitter(state.copywith(status: FormzStatus.submissionInProgress));
    UnBlockResponse? response = await  _blockApiProvider.setUnBlock(SessionUser.token, event.userId, "1");
    print(response);
    if (response != null && response.message == "OK") {
      emitter(state.copywith(status: FormzStatus.submissionSuccess, unBlockResponse: response));
    } else {
      emitter(state.copywith(status: FormzStatus.submissionFailure, unBlockResponse: response));
    }
  }

}