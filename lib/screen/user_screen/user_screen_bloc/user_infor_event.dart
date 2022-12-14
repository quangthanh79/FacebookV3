

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class UserInforEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class LoadUserEvent extends UserInforEvent{}
class BackgroundLoadUserEvent extends UserInforEvent{}
class ReloadUserEvent extends UserInforEvent{}