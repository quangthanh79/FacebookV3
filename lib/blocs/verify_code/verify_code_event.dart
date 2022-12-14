

import 'package:equatable/equatable.dart';

abstract class  VerifyCodeEvent extends Equatable{
  const VerifyCodeEvent();

  @override
  List<Object> get props => [];
}

class CheckVerifyCodeChanged extends VerifyCodeEvent{
  const CheckVerifyCodeChanged(this.code);
  final String code;
  @override
  List<Object> get props => [this.code];
}

class GetVerifyCodeChanged extends VerifyCodeEvent{
  const GetVerifyCodeChanged();
  @override
  List<Object> get props => [];
}