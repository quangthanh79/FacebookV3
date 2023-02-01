
import 'package:facebook_auth/blocs/block/BlockApiProvider.dart';
import 'package:facebook_auth/blocs/block/BlockModel.dart';
import 'package:facebook_auth/blocs/block/block_event.dart';
import 'package:facebook_auth/blocs/block/block_state.dart';
import 'package:facebook_auth/screen/profile_screen/block_screen/ItemBlockScreen.dart';
import 'package:facebook_auth/utils/Progress_Dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../blocs/block/block_bloc.dart';

class ListBlockScreen extends StatelessWidget{
  ListBlockScreen(Key? key) : super(key: key);
  static BlockBloc? blockBloc;
  BlockApiProvider blockApiProvider = BlockApiProvider();
  @override
  Widget build(BuildContext context) {
    ListBlockScreen.blockBloc= BlockBloc(blockApiProvider)..add(GetListBlockEvent());

    return Scaffold(
      appBar: AppBar(
          key: key,
          elevation: 2.0,
          centerTitle: false,
          backgroundColor: Colors.white,
          title: Text("Chặn", style: TextStyle(color: Colors.black,),),
          leading: GestureDetector(
            child: Icon(Icons.arrow_back, color: Colors.black,),
            onTap: () {
              Navigator.pop(context);
            },
          )
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20.0,),
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 20.0), child: Text("Người bị chặn", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),),),
          Padding(padding: EdgeInsets.only(left: 20.0, bottom: 20.0), child: Text("\nMột khi bạn đã chặn ai đó, họ sẽ không xem được nội dung bạn đăng trên dòng thời gian của mình, gắn thẻ bạn, mời bạn tham gia sự kiện hoặc nhóm, bắt đầu cuộc trò chuyện với bạn hay thêm bạn làm bạn bè. Lưu ý: Điều này không bao gồm các ứng dụng, trò chơi hay nhóm mà cả bạn và người này đều tham gia.", style: TextStyle(fontSize: 14.0, color: Colors.grey),)),
          BlocBuilder(
            bloc: ListBlockScreen.blockBloc,
            builder: (context, state) {
              BlockModel? resultBlocModel;
              if (state is BlockState) {
                if(state.statusGetListBlock == FormzStatus.submissionSuccess){
                  progressDialog.hideProgress();
                  resultBlocModel = state.blockModel;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: resultBlocModel?.data?.length,
                    itemBuilder: (BuildContext context, int position) {
                      return ItemBlockScreen(key, resultBlocModel?.data?[position]);
                    }
                  );
                } else if (state.statusGetListBlock == FormzStatus.submissionInProgress) {
                  return Center(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.black38,
                      ),
                    ),
                  );
                }
              } else {
                return Padding(padding: EdgeInsets.only(left: 20.0), child: Text("Danh sách chặn trống"));
              }
              return Padding(padding: EdgeInsets.only(left: 20.0), child: Text("Danh sách chặn trống"));
            }
          )
        ],
      ),
    );
  }


}