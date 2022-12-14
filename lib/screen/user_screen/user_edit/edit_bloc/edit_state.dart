

import 'dart:math';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class EditState extends Equatable{
  static int count = 0;
  late int random;
  @override
  List<Object?> get props => [random];
  EditState({int? random}){
    if (random != null){
      this.random = random;
    } else{
      this.random = Random().nextInt(10000);
    }
  }
}
