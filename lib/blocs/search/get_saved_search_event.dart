

import 'package:equatable/equatable.dart';

class SavedSearchEvent extends Equatable {

  const SavedSearchEvent();

  @override
  List<Object?> get props => [];

}

class GetSavedSearchEvent extends SavedSearchEvent{}

class DeleteSavedSearchEvent extends SavedSearchEvent {
  String savedSearchId;
  DeleteSavedSearchEvent({required this.savedSearchId});

  @override
  List<Object?> get props => [savedSearchId];
}