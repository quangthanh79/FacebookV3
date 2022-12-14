
import 'package:facebook_auth/icon/dropdown_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionProfile extends StatelessWidget{
  OptionProfile(Key? key, this.title, this.icon) : super(key: key);

  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 0.5
          )
        )
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(15.0), child: this.icon,),
          Expanded(child:
              Text(this.title, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),)
          ),
          Padding(padding: EdgeInsets.all(10.0), child: Icon(Dropdown.keyboard_arrow_down),)
        ],
      ),
    );
  }

}