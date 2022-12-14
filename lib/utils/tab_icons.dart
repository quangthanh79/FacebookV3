import 'package:flutter/material.dart';

import '../models/tabIcon_data.dart';
import 'app_theme.dart';

class TabIcons extends StatefulWidget {
  const TabIcons({Key? key, this.tabIconData})
      : super(key: key);

  final TabIconData? tabIconData;
  @override
  _TabIconsState createState() => _TabIconsState();
}

class _TabIconsState extends State<TabIcons> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child:  Center(
        child: IgnorePointer(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 0)),
              Column(
                children: [
                  Expanded(child: SizedBox()),
                  widget.tabIconData!.isSelected ?
                  widget.tabIconData!.iconSelected!
                      : widget.tabIconData!.iconUnselected!,
                  Expanded(child: SizedBox()),
                ] ,
              ),
            ],
          ),
        ),
      ),


    );
  }
}