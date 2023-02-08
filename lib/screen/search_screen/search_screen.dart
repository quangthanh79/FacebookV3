import 'package:facebook_auth/blocs/search/get_saved_search_event.dart';
import 'package:facebook_auth/blocs/search/get_saved_search_state.dart';
import 'package:facebook_auth/data/datasource/remote/get_saved_search_provider.dart';
import 'package:facebook_auth/data/repository/post_repository_impl.dart';
import 'package:facebook_auth/screen/home_screen/home_bloc/home_bloc.dart';
import 'package:facebook_auth/screen/home_screen/home_body.dart';
import 'package:facebook_auth/screen/search_screen/item_saved_search.dart';
import 'package:facebook_auth/utils/Progress_Dialog.dart';
import 'package:facebook_auth/utils/app_theme.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../blocs/search/get_saved_search_bloc.dart';
import '../../data/models/get_saved_search_response.dart';

class MyCustomDelegate extends SearchDelegate<String> {
  List<ItemSavedSearchModel>? listSavedSearch;
  late GetSavedSearchBloc getSavedSearchBloc =
      GetSavedSearchBloc(GetSavedSearchProvider());

  MyCustomDelegate() : super(searchFieldLabel: 'Tìm kiếm');

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      textTheme: TextTheme(
        headline5: TextStyle(fontSize: 16.0, color: Colors.grey),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        centerTitle: true,
        titleSpacing: 0.0,
        elevation: 0.4,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(90.0)),
            borderSide: BorderSide(
              color: Colors.transparent,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(90.0)),
            borderSide: BorderSide(
              color: Colors.transparent,
            )),
        suffixIconColor: Colors.grey,
        isDense: true,
        contentPadding:
            EdgeInsets.only(left: 16.0, bottom: 8.0, top: 8.0, right: 8.0),
        filled: true,
        fillColor: AppTheme.grey200,
        // Use this change the placeholder's text style
        hintStyle: TextStyle(fontSize: 16.0),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            query = '';
          },
          icon: Container(
            height: 24,
            width: 24,
            child: Icon(
              Icons.clear,
              color: Colors.grey,
              size: 16,
            ),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppTheme.grey200),
          ),
        )
        //Icon(Icons.clear, color: Colors.grey, size: 20.0,))
      ];

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.arrow_back_outlined,
        color: Colors.black,
        size: 30.0,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc(getIt(), getIt()),
        child: HomeBody(
          type: PostType.search,
          keyword: query,
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocProvider(
        create: (context) {
          getSavedSearchBloc = GetSavedSearchBloc(GetSavedSearchProvider());
          getSavedSearchBloc.add(GetSavedSearchEvent());
          return getSavedSearchBloc;
        },
        child: BlocListener<GetSavedSearchBloc, GetSavedSearchState>(
          listener: (context, state) {
            switch (state.getSavedSearchStatus) {
              case FormzStatus.submissionInProgress:
                progressDialog.showProgress();
                break;
              case FormzStatus.submissionSuccess:
                progressDialog.hideProgress();
                listSavedSearch = state.getSavedSearchResponse?.data;
                break;
              case FormzStatus.submissionFailure:
                progressDialog.hideProgress();
                break;
            }
          },
          child: BlocBuilder<GetSavedSearchBloc, GetSavedSearchState>(
              bloc: getSavedSearchBloc,
              builder: (context, state) {
                if (state is GetSavedSearchState && listSavedSearch != null) {
                  List<ItemSavedSearchModel> listToShow =
                      <ItemSavedSearchModel>[];
                  if (query.isNotEmpty) {
                    for (var i in listSavedSearch!) {
                      if (i.keyword!.contains(query, 0)) {
                        listToShow.add(i);
                      }
                    }
                  } else {
                    for (var i in listSavedSearch!) {
                      listToShow.add(i);
                    }
                  }
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: listToShow.length,
                      itemBuilder: (BuildContext context, int position) {
                        return ListTile(
                          title: ItemSavedSearch(
                              listToShow[position], getSavedSearchBloc),
                          onTap: () {
                            query = listToShow[position].keyword ?? "";
                            showResults(context);
                          },
                        );
                      });
                } else {
                  return Text("");
                }
              }),
        ));
  }
}
