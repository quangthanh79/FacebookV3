
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TagProfile extends StatelessWidget{
  TagProfile(Key? key, this.title, this.icon) : super(key: key);

  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Expanded( child:
       Padding(padding: EdgeInsets.all(5.0), child:
         Container(
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
           child: Column( crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Padding(padding: EdgeInsets.all(10.0), child: this.icon,),
               Padding(padding: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0), child:Text(this.title, style: TextStyle(fontWeight: FontWeight.bold),)),
             ],
           ),
         ),
       ),

    );
  }

}