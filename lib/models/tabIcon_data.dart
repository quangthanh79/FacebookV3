
import 'package:flutter/material.dart';

import '../utils/app_theme.dart';


class TabIconData {
  static const _kFontFam = 'ABC';
  static const String? _kFontPkg = null;
  static const Color colorUnselected = AppTheme.grey;
  static const Color colorSelected = AppTheme.primary;

  static Color nearlyDarkBlue = Color(0xFF2D74E7);
  static const IconData receipt = IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);



  TabIconData({
    this.iconUnselected,
    this.iconSelected,
    this.index = 0,
    this.isSelected = false,
});
  Widget? iconSelected;
  Widget? iconUnselected;
  bool isSelected = false;
  bool isSelecte = false;
  int index;



  static List<TabIconData> tabIconsList = [
    TabIconData(
      iconUnselected: Image.asset("assets/images/home_non.png",height: 24,width: 24,),
      iconSelected: Image.asset("assets/images/home.png",height: 24,width: 24,),
      index: 0,
      //hard code
      isSelected: true,
    ),
    TabIconData(
      iconUnselected: Image.asset("assets/images/messenger_non.png",height: 24,width: 24,),
      iconSelected: Image.asset("assets/images/messenger.png",height: 24,width: 24,),
      index: 1,
      isSelected: false,
    ),
    TabIconData(
      iconUnselected: Image.asset("assets/images/video_non.png",height: 29,width: 29,),
      iconSelected: Image.asset("assets/images/video.png",height: 29,width: 29,),
      index: 2,
      isSelected: false,
    ),
    TabIconData(
      iconUnselected: Image.asset("assets/images/bell_non.png",height: 27,width: 27,),
      iconSelected: Image.asset("assets/images/bell.png",height: 27,width: 27,),
      index: 3,
      isSelected: false,
    ),
    TabIconData(
      iconUnselected: Image.asset("assets/images/menu_non.png",height: 27,width: 27,),
      iconSelected: Image.asset("assets/images/menu.png",height: 27,width: 27,),
      index: 4,
      isSelected: false,
    ),
  ];
}