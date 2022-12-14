

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemBlockScreen extends StatelessWidget{
  ItemBlockScreen(Key? key, this.username): super(key: key);

  final String username;

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
              Padding(padding: EdgeInsets.only(left: 20.0), child: Text(username, style: TextStyle(color: Colors.black),),),
              Expanded(child: SizedBox(),),
              Padding(padding: EdgeInsets.only(right: 20.0), child: getButtonUnblock()),
            ],
          )
      ),
    );
  }

  Widget getButtonUnblock(){
    return OutlinedButton(
        onPressed: (){
          //sau có api bỏ chặn thì code tiếp ở đây
        },
        child: Text("Bỏ chặn", style: TextStyle(color: Colors.grey, fontSize: 11.0),)
    );
  }

}