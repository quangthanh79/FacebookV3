import 'package:facebook_auth/firebase/register_token.dart';
import 'package:facebook_auth/icon/loupe_icons.dart';
import 'package:facebook_auth/screen/chat_screen/chat_screen.dart';
import 'package:facebook_auth/screen/home_screen/add_post/add_post_screen.dart';
import 'package:facebook_auth/screen/notify_screen/NotifyScreen.dart';
import 'package:facebook_auth/screen/profile_screen/ProfileScreen.dart';
import 'package:facebook_auth/screen/video_screen/VideoScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../icon/add_icons.dart';
import '../models/tabIcon_data.dart';
import '../utils/app_theme.dart';
import '../utils/tab_icons.dart';
import 'home_screen/home_screen.dart';

/**
 * Created by @Author: Tuan Pham Anh
 * Project : Facebook
 * Create Time : 02:26 - 27/10/2022
 * For all issue contact me : tuan.pa173443@sis.hust.edu.vn
 */

class MainFacebookScreen extends StatefulWidget {
  @override
  MainFacebookScreenState createState() => MainFacebookScreenState();

  static Route<void> route() {
    return PageRouteBuilder(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (BuildContext context, _, __) {
          return MainFacebookScreen();
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return SlideTransition(
            child: child,
            position: Tween<Offset>(
              begin: const Offset(0.5, 0),
              end: Offset.zero,
            ).animate(animation),
          );
        });
  }
}

class MainFacebookScreenState extends State<MainFacebookScreen>
    with TickerProviderStateMixin {
  final List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  var scrollController = ScrollController();
  bool checkIndexZero = true;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -0.5),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: const Interval(
      0.0,
      0.2,
      curve: Curves.linear,
    ),
  ));
  late final Animation<Offset> _tempAnimation = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: const Offset(0.0, -1.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: const Interval(
      0.0,
      0.2,
      curve: Curves.linear,
    ),
  ));
  late final TabController con = TabController(vsync: this, length: 5);

  @override
  void initState() {
    super.initState();
    _controller.animateTo(0.0);
    registerToken();
  }

  @override
  Widget build(BuildContext context) {
    con.addListener(() {
      if (!con.indexIsChanging) {
        setRemoveAllSelection(tabIconsList[con.index]);
      }
      if (con.index != 0) {
        _controller.animateTo(0.2);
      } else {
        _controller.animateTo(0.0);
      }
    });
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'OpenSans', platform: TargetPlatform.iOS),
        home: Container(
          color: Colors.white,
          child: SafeArea(
              bottom: true,
              top: true,
              child: Scaffold(
                body: Stack(
                  children: [getBody(), getHeader(), getTempHide(context)],
                ),
              )),
        ));
  }

  void setRemoveAllSelection(TabIconData? tabIconData) {
    if (!mounted) return;
    setState(() {
      tabIconsList.forEach((TabIconData tab) {
        tab.isSelected = false;
        if (tabIconData!.index == tab.index) {
          tab.isSelected = true;
        }
      });
    });
  }

  Widget getBody() {
    return TabBarView(
      controller: con,
      children: <Widget>[
        HomeScreen(),
        ChatScreen(),
        VideoScreen(),
        NotifyScreen(),
        ProfileScreen(),
      ],
    );
  }

  Widget getHeader() {
    return SlideTransition(
        position: _offsetAnimation,
        child: Container(
          height: 102,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(top: 10, bottom: 5, left: 15),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/LogoFb.png',
                      height: 28,
                    ),
                    Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddPostView(
                              isEditing: false,
                            ),
                          )),
                      child: Container(
                        height: 36,
                        width: 36,
                        child: Icon(
                          Add.add,
                          size: 15,
                        ),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppTheme.grey200),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 36,
                      width: 36,
                      child: Icon(
                        Loupe.loupe,
                        size: 17,
                      ),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppTheme.grey200),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              getTabBar()
            ],
          ),
        ));
  }

  Widget getTempHide(BuildContext context) {
    return SlideTransition(
        position: _tempAnimation,
        child: Container(
            height: 51,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: SizedBox(
              height: 0,
            )));
  }

  Widget getTabBar() {
    return SizedBox(
      child: Container(
        height: 46,
        decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppTheme.grey500),
            ),
            color: Colors.white),
        child: TabBar(
          controller: con,
          indicatorColor: AppTheme.primary,
          overlayColor: MaterialStateProperty.all(Colors.yellow),
          padding: EdgeInsets.only(left: 0, right: 0),
          labelStyle: TextStyle(fontSize: 14),
          labelColor: AppTheme.primary,
          labelPadding: EdgeInsets.zero,
          unselectedLabelColor: Colors.grey[600],
          unselectedLabelStyle: TextStyle(fontSize: 14),
          onTap: (index) {
            setRemoveAllSelection(tabIconsList[index]);
          },
          tabs: [
            TabIcons(
              tabIconData: tabIconsList[0],
            ),
            TabIcons(
              tabIconData: tabIconsList[1],
            ),
            TabIcons(
              tabIconData: tabIconsList[2],
            ),
            TabIcons(
              tabIconData: tabIconsList[3],
            ),
            TabIcons(
              tabIconData: tabIconsList[4],
            ),
          ],
        ),
      ),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );

  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 50.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
