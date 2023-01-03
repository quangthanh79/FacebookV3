
import 'package:facebook_auth/blocs/search/get_saved_search_event.dart';
import 'package:facebook_auth/blocs/search/get_saved_search_state.dart';
import 'package:facebook_auth/data/datasource/remote/get_saved_search_provider.dart';
import 'package:facebook_auth/data/models/delete_saved_search_response.dart';
import 'package:facebook_auth/data/models/get_saved_search_response.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class GetSavedSearchBloc extends Bloc<SavedSearchEvent, GetSavedSearchState>{

  final GetSavedSearchProvider getSavedSearchProvider;

  GetSavedSearchBloc(this.getSavedSearchProvider): super(GetSavedSearchState()){
    on<GetSavedSearchEvent>(_onGetSavedSearch);
    on<DeleteSavedSearchEvent>(_onDeleteSavedSearch);
  }

  Future<void> _onGetSavedSearch(GetSavedSearchEvent event, Emitter<GetSavedSearchState> emitter) async {
    emitter(state.copywith(FormzStatus.submissionInProgress, null, null, null));
    GetSavedSearchResponse? response = await getSavedSearchProvider.getSavedSearch(SessionUser.token, "0", "100");
    if (response?.message == "OK") {
      emitter(state.copywith(FormzStatus.submissionSuccess, null, response, null));
    } else {
      emitter(state.copywith(FormzStatus.submissionFailure, null, response, null));
    }
  }

  Future<void> _onDeleteSavedSearch(DeleteSavedSearchEvent event, Emitter<GetSavedSearchState> emitter) async {
    emitter(state.copywith(null, FormzStatus.submissionInProgress, null, null));
    DeleteSavedSearchResponse? response = await getSavedSearchProvider.deleteSavedSearch(SessionUser.token, "0", event.savedSearchId);
    if (response?.message == "OK") {
      emitter(state.copywith(null, FormzStatus.submissionSuccess, null, response));
    } else {
      emitter(state.copywith(null, FormzStatus.submissionFailure, null, response));
    }
  }
}