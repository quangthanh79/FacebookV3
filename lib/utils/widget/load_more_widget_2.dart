import 'package:facebook_auth/data/models/page_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadMoreWidget2<T> extends StatefulWidget {
  final Future<PageData<T>> Function(int) onLoadData;
  final Widget Function(T) itemBuilder;
  final Widget itemNoData;
  final int? countReload;
  final Axis? axisContent;
  final Widget? itemFinish;

  LoadMoreWidget2(
      { required this.onLoadData,
        required this.itemBuilder,
        required this.itemNoData,
        this.countReload,
        this.axisContent,
        this.itemFinish = null,
        Key? key})
      : super(key: key);

  @override
  State<LoadMoreWidget2> createState() => _LoadMoreWidgetState<T>(itemBuilder);
}

class _LoadMoreWidgetState<T> extends State<LoadMoreWidget2> {
  final Widget Function(T) itemBuilder;

  // At the beginning, we fetch the first 20 posts
  late int _page;

  // you can change this value to fetch more or less posts per page (10, 15, 5, etc)
  // final int _limit = 20;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  bool _isFirstLoadRunning = false;

  // This holds the posts fetched from the server
  PageData<T>? _currentPageData = null;
  List<T> _data = [];

  _LoadMoreWidgetState(this.itemBuilder);

  // This function will be called when the app launches (see the initState function)
  void _firstLoad() async {

    try {
      setState(() {
        _isFirstLoadRunning = true;
      });
      _currentPageData = (await widget.onLoadData(1)) as PageData<T>?;
      setState(() {
        _data = _currentPageData?.data ?? [];
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
      _page = 1;
      _hasNextPage = true;
    });
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1;// Increase _page by 1
      try {
        if (_page > (_currentPageData?.data?.length ?? 0)) {
          setState(() {
            _hasNextPage = false;
            _isLoadMoreRunning = false;
          });
        } else {
          _currentPageData = (await widget.onLoadData(_page)) as PageData<T>?;
          final List<T>? fetchedList = _currentPageData?.data;
          if (fetchedList != null && fetchedList.isNotEmpty == true) {
            print("FETCHEDLIST LENGTH = "+ fetchedList.length.toString());
            setState(() {
              _data.addAll(fetchedList);
            });
          } else {
            // This means there is no more data
            // and therefore, we will not send another GET request
            setState(() {
              _hasNextPage = false;
              _isLoadMoreRunning = false;
            });
          }
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    print("Vao day roi");
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }
  @override
  void didUpdateWidget(LoadMoreWidget2 oldWidget) {
    if(widget.countReload != oldWidget.countReload){
      print("Da thay doi");
      _firstLoad();
    }else{
      print("Chua thay doi");
    }
  }
  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return _isFirstLoadRunning
        ? Center(
      child: Lottie.asset(
        'assets/animator_flutter.json',
        width: 60,
        height: 60,
        fit: BoxFit.fill,
      ),
    )
        : (_data.length == 0 ?
    widget.itemNoData :
    ListView.separated(
      controller: _controller,
      scrollDirection: widget.axisContent ?? Axis.vertical,
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemCount: _data.length + (_hasNextPage || _isLoadMoreRunning ? 1 : 0),
      itemBuilder:  (_, index) {
        if (index < _data.length) {
          return itemBuilder(_data[index]);
        }
        // when the _loadMore function is running
        if (_isLoadMoreRunning == true) {
          return  Padding(
            padding: EdgeInsets.only(top: 10, bottom: 40),
            child: Center(
              child: Lottie.asset(
                'assets/animator_flutter.json',
                width: 60,
                height: 60,
                fit: BoxFit.fill,
              ),
            ),
          );
        }
        return widget.itemFinish ?? SizedBox();
      },
    )
        //   ListView.separated(
        //       controller: _controller,
        //       padding: EdgeInsets.only(top: 20,bottom: 30),
        //       separatorBuilder: (context, index) => const SizedBox(height: 18),
        //       itemCount: _data.length + (!_hasNextPage || _isLoadMoreRunning ? 1 : 0),
        //       itemBuilder: (_, index) {
        //           if (index < _data.length) {
        //           return itemBuilder(_data[index]);
        //           }
        // // when the _loadMore function is running
        //           if (_isLoadMoreRunning == true) {
        //               return  Padding(
        //                   padding: EdgeInsets.only(top: 10, bottom: 40),
        //                   child: Center(
        //                     child: Lottie.asset(
        //                       'assets/animator_flutter.json',
        //                       width: 60,
        //                       height: 60,
        //                       fit: BoxFit.fill,
        //                     ),
        //                       ),
        //               );
        //           }
        //           return widget.itemFinish ?? SizedBox();
        //       },
        // )


    );
  }
}