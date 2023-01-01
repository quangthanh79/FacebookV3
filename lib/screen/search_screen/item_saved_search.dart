

import 'package:facebook_auth/blocs/search/get_saved_search_bloc.dart';
import 'package:facebook_auth/blocs/search/get_saved_search_event.dart';
import 'package:facebook_auth/blocs/search/get_saved_search_state.dart';
import 'package:facebook_auth/data/datasource/remote/get_saved_search_provider.dart';
import 'package:facebook_auth/data/models/get_saved_search_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ItemSavedSearch extends StatelessWidget{

  ItemSavedSearchModel? itemSavedSearchModel;
  GetSavedSearchBloc getSavedSearchBloc;

  ItemSavedSearch(this.itemSavedSearchModel, this.getSavedSearchBloc);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GetSavedSearchBloc(GetSavedSearchProvider()),
        child: BlocListener<GetSavedSearchBloc, GetSavedSearchState>(
          listener: (context, state){
            switch(state.deleteSavedSearchStatus){
              case FormzStatus.submissionInProgress:
                break;

              case FormzStatus.submissionSuccess:
                getSavedSearchBloc.add(GetSavedSearchEvent());
                SnackBar snackBar = SnackBar(
                  content: Text("Đã xoá tìm kiếm " + (itemSavedSearchModel?.keyword ?? "") + " khỏi lịch sử của bạn"),
                  duration: Duration(seconds: 3),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentMaterialBanner()
                  ..showSnackBar(snackBar);
                break;

              case FormzStatus.submissionFailure:
                const SnackBar snackBar = SnackBar(
                  content: Text("Đã có lỗi xảy ra!"),
                  duration: Duration(seconds: 1),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentMaterialBanner()
                  ..showSnackBar(snackBar);
                break;
            }
          },
          child: Builder(
            builder: (BuildContext newContext){
              return Container(
                  padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 0.0, right: 0.0),
                  child:
                  Row(
                    children: <Widget>[
                      Icon(Icons.watch_later_outlined, color: Colors.black38, size: 30.0,),
                      Padding(padding: EdgeInsets.only(left: 16.0), child: Text(itemSavedSearchModel?.keyword ?? "", style: TextStyle(fontSize: 18.0),),),
                      Expanded(child: SizedBox(),),
                      GestureDetector(
                        child: Icon(Icons.clear_rounded, size: 30.0, color: Colors.black38,),
                        onTap: (){
                          newContext.read<GetSavedSearchBloc>().add(DeleteSavedSearchEvent(savedSearchId: itemSavedSearchModel?.id ?? ""));
                        },
                      )
                    ],
                  )
              );
            },
          ),
        ),
    );
  }

}