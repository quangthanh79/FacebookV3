

part of 'edit_bloc.dart';

class EditEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class ReloadEvent extends EditEvent{}
class CommitChangeEvent extends EditEvent{}

