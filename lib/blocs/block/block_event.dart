
import 'package:equatable/equatable.dart';

class BlockEvent extends Equatable{
  const BlockEvent();

  @override
  List<Object?> get props => [];

}

class GetListBlockEvent extends BlockEvent{

  const GetListBlockEvent();

  @override
  List<Object> get props => [];

}

class SetUnBlockEvent extends BlockEvent{
  String userId;

  SetUnBlockEvent({required this.userId});

  @override
  List<Object> get props => [userId];

}