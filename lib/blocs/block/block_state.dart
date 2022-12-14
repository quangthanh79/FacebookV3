

import 'package:equatable/equatable.dart';
import 'package:facebook_auth/blocs/block/BlockModel.dart';
import 'package:formz/formz.dart';

class BlockState extends Equatable{

  final FormzStatus statusGetListBlock;
  final BlockModel? blockModel;

  const BlockState({this.statusGetListBlock = FormzStatus.pure, this.blockModel});

  BlockState copywith({FormzStatus? status, BlockModel? blockModel}){
    return BlockState(statusGetListBlock: status ?? this.statusGetListBlock, blockModel: blockModel);
  }

  @override
  List<Object?> get props => [this.statusGetListBlock, this.blockModel];

}