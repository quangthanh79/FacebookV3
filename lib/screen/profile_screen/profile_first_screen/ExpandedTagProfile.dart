
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandedTagProfile extends StatelessWidget{
  ExpandedTagProfile(Key? key, this.title, this.icon) : super(key: key);

  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Expanded( child:
      Padding(padding: EdgeInsets.all(2.0), child:
        Container(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0.0,
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 2.0),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10.0), child: this.icon,),
              Padding(padding: EdgeInsets.only(left: 8.0), child:Text(this.title, style: TextStyle(fontWeight: FontWeight.bold),)),
            ],
          ),
        ),
      ),

    );
  }

}