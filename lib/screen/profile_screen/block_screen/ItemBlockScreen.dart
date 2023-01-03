

import 'package:facebook_auth/blocs/block/BlockModel.dart';
import 'package:facebook_auth/screen/profile_screen/block_screen/ListBlockScreen.dart';
import 'package:facebook_auth/utils/Progress_Dialog.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../blocs/block/BlockApiProvider.dart';
import '../../../blocs/block/block_event.dart';
import '../../../blocs/block/unblock_bloc.dart';
import '../../../blocs/block/unblock_state.dart';

class ItemBlockScreen extends StatelessWidget{
  ItemBlockScreen(Key? key, this.userBlockInfo): super(key: key);

  final BlockItem? userBlockInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0),
      child: Expanded(
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("images/avatarDefault.png"),
              ),
              Padding(padding: EdgeInsets.only(left: 20.0), child: Text(userBlockInfo?.username ?? "", style: TextStyle(color: Colors.black),),),
              Expanded(child: SizedBox(),),
              Padding(padding: EdgeInsets.only(right: 20.0), child: getButtonUnblock(userBlockInfo, context)),
            ],
          )
      ),
    );
  }

  Widget getButtonUnblock(BlockItem? userBlockInfo, BuildContext context){
    return BlocProvider(
        create: (context) => UnBlockBloc(BlockApiProvider()),
        child: BlocListener<UnBlockBloc, UnBlockState>(
          listener: (context, state){
            switch(state.statusSetUnBlock){
              case FormzStatus.submissionInProgress:
                progressDialog.showProgress();
                break;
              case FormzStatus.submissionSuccess:
                progressDialog.hideProgress();
                const SnackBar snackBar = SnackBar(
                  content: Text("Bỏ chặn thành công"),
                  duration: Duration(seconds: 1),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentMaterialBanner()
                  ..showSnackBar(snackBar);
                ListBlockScreen.blockBloc?.add(GetListBlockEvent());
                break;
              case FormzStatus.submissionFailure:
                progressDialog.hideProgress();
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
              return OutlinedButton(
                  onPressed: (){
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text("Bỏ chặn " + (userBlockInfo?.username ?? "")),
                        content: Text('Nếu bạn bỏ chặn, người này có thể xem dòng thời gian của bạn hoặc liên hệ với bạn, tuỳ thuộc vào cài đặt của bạn\nCó thể khôi phục lại các thẻ mà bạn và người này đã thêm cho nhau trước đó\nBạn phải đợi 48 giờ nếu muốn chặn lại người này'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Huỷ'),
                          ),
                          TextButton(
                            onPressed: () {
                              newContext.read<UnBlockBloc>().add(SetUnBlockEvent(userId: userBlockInfo?.id ?? ""));
                              Navigator.pop(context);
                            },
                            child: const Text('Bỏ chặn'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text("Bỏ chặn", style: TextStyle(color: Colors.grey, fontSize: 11.0),)
              );
            },
          ),
        ),
    );
  }

}