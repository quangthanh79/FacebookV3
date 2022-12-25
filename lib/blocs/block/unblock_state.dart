

import 'package:equatable/equatable.dart';
import 'package:facebook_auth/data/models/unblock_response.dart';
import 'package:formz/formz.dart';

class UnBlockState extends Equatable{

  final FormzStatus statusSetUnBlock;
  final UnBlockResponse? unBlockResponse;

  const UnBlockState({this.statusSetUnBlock = FormzStatus.pure, this.unBlockResponse});

  UnBlockState copywith({FormzStatus? status, UnBlockResponse? unBlockResponse}){
    return UnBlockState(statusSetUnBlock: status ?? this.statusSetUnBlock, unBlockResponse: unBlockResponse);
  }

  @override
  List<Object?> get props => [this.statusSetUnBlock, this.unBlockResponse];

}