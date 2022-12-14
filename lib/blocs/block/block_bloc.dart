

import 'package:facebook_auth/blocs/block/BlockApiProvider.dart';
import 'package:facebook_auth/blocs/block/BlockModel.dart';
import 'package:facebook_auth/blocs/block/block_event.dart';
import 'package:facebook_auth/blocs/block/block_state.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class BlockBloc extends Bloc<BlockEvent, BlockState>{
  final BlockApiProvider _blockApiProvider;

  BlockBloc(this._blockApiProvider) : super(BlockState()) {
    on<GetListBlockEvent>(_onGetListBlock);
  }
  
  Future<void> _onGetListBlock(GetListBlockEvent event, Emitter<BlockState> emitter) async{
    // emitter(state.copywith(status: FormzStatus.submissionInProgress));
    BlockModel? response = await  _blockApiProvider.getListBlock(SessionUser.token, "0", "100");
    print(response);
    if (response != null && response.message == "OK") {
      emitter(state.copywith(status: FormzStatus.submissionSuccess, blockModel: response));
    } else {
      emitter(state.copywith(status: FormzStatus.submissionFailure, blockModel: response));
    }
  }

}