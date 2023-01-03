

import 'package:equatable/equatable.dart';
import 'package:facebook_auth/data/models/delete_saved_search_response.dart';
import 'package:facebook_auth/data/models/get_saved_search_response.dart';
import 'package:formz/formz.dart';

class GetSavedSearchState extends Equatable {

  FormzStatus? getSavedSearchStatus;
  FormzStatus? deleteSavedSearchStatus;
  GetSavedSearchResponse? getSavedSearchResponse;
  DeleteSavedSearchResponse? deleteSavedSearchResponse;

  GetSavedSearchState({
        this.getSavedSearchStatus = FormzStatus.pure,
        this.deleteSavedSearchStatus = FormzStatus.pure,
        this.getSavedSearchResponse,
        this.deleteSavedSearchResponse,
      });

  GetSavedSearchState copywith(
      FormzStatus? status,
      FormzStatus? deleteStatus,
      GetSavedSearchResponse? response,
      DeleteSavedSearchResponse? deleteSavedSearchResponse
      )
  {
    return GetSavedSearchState(
        getSavedSearchStatus: status ?? this.getSavedSearchStatus,
        deleteSavedSearchStatus:  deleteStatus ?? this.deleteSavedSearchStatus,
        getSavedSearchResponse: response,
        deleteSavedSearchResponse: deleteSavedSearchResponse);
  }

  @override
  List<Object?> get props => [this.getSavedSearchStatus, this.deleteSavedSearchStatus, this.getSavedSearchResponse, this.deleteSavedSearchResponse];

}