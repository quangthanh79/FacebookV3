// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:facebook_auth/screen/home_screen/home_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:facebook_auth/screen/home_screen/model/post.dart';
import 'package:facebook_auth/screen/home_screen/post_item/post_item.dart';

import '../post_item/bloc/post_item_bloc.dart';

class PostInImageScreen extends StatelessWidget {
  final int index;
  const PostInImageScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VisibleModel(),
      child: Consumer<VisibleModel>(
        builder: (context, value, child) => Scaffold(
          body: SafeArea(
            child: Container(
              color: Colors.black,
              child: Stack(
                children: [
                  GestureDetector(
                    onPanUpdate: (details) {
                      // Swiping in right direction.
                      if (details.delta.dx > 100) {
                        Navigator.maybePop(context);
                      }
                      if (details.delta.dy > 100) {
                        Navigator.maybePop(context);
                      }
                      if (details.delta.dy < 100) {
                        Navigator.maybePop(context);
                      }
                      // Swiping in left direction.
                      if (details.delta.dx < 100) {
                        Navigator.maybePop(context);
                      }
                    },
                    onTap: () {
                      value.changeState();
                    },
                    child: SizedBox.expand(
                      child: Image.asset(
                        context
                            .read<ListPostNotify>()
                            .items[index]
                            .assetContentUrl![0],
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Controller(
                    postIndex: index,
                    post: context.read<ListPostNotify>().items[index],
                    visibleModel: value,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Controller extends StatefulWidget {
  final Post post;
  final VisibleModel visibleModel;
  final int postIndex;
  const Controller({
    Key? key,
    required this.post,
    required this.visibleModel,
    required this.postIndex,
  }) : super(key: key);

  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  bool showMoreText = false;
  int sized = 3;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.visibleModel.visible ? 1 : 0,
      duration: const Duration(milliseconds: 200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(top: 4, right: 4),
              child: Image.asset('assets/images/menu_3_dots_vertical.png')),
          Container(
            color: Colors.black.withOpacity(0.4),
            padding: const EdgeInsets.all(6),
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height / sized,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.post.userName,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  !showMoreText
                      ? ContentText(
                          content: widget.post.content,
                          textColor: Colors.white,
                          voidCallback: () {
                            setState(() {
                              sized = 2;
                              showMoreText = true;
                            });
                          },
                        )
                      : Expanded(
                          flex: 1,
                          child: SingleChildScrollView(
                            child: Text(
                              widget.post.content,
                              style: const TextStyle(color: Colors.white),
                            ),
                          )),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.post.time,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  BlocProvider(
                    create: (context) => PostItemBloc()
                      ..add(PostInitEvent(
                          isSelfLiking: widget.post.isSelfLiking)),
                    child: Bottom(
                      isFromDark: true,
                      postIndex: widget.postIndex,
                      textColor: Colors.white,
                      isDarkTheme: true,
                    ),
                  )
                ]),
          )
        ],
      ),
    );
  }
}

class VisibleModel extends ChangeNotifier {
  bool visible = true;
  void changeState() {
    visible = !visible;
    notifyListeners();
  }
}
