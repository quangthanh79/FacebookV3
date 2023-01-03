// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:facebook_auth/data/repository/post_repository_impl.dart';
import 'package:facebook_auth/screen/home_screen/comment_item/comment_item.dart';
import 'package:facebook_auth/screen/home_screen/home_body.dart';
import 'package:facebook_auth/screen/home_screen/model/post.dart';
import 'package:facebook_auth/utils/injection.dart';

import '../../../utils/constant.dart';
import '../like_bloc/like_bloc.dart';
import '../model/comment.dart';
import 'comment_bloc/comment_bloc.dart';

class CommentListView extends StatefulWidget {
  const CommentListView({
    Key? key,
    required this.comments,
    required this.focus,
    required this.post,
    required this.index,
    required this.isFromDark,
    required this.type,
  }) : super(key: key);

  final List<Comment> comments;
  final bool focus;
  final Post post;
  final int index;
  final bool isFromDark;
  final PostType type;

  @override
  State<CommentListView> createState() => _CommentListViewState();
}

class _CommentListViewState extends State<CommentListView> {
  late VoidCallback close;
  bool isShowKeyboard = false;
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isTop) {
      _scrollController.removeListener(_onScroll);
      close.call();
    }
  }

  bool get _isTop {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll < (maxScroll * -0.1);
  }

  @override
  Widget build(BuildContext context) {
    close = () {
      Navigator.pop(context);
    };
    final viewInsets = EdgeInsets.fromWindowPadding(
        WidgetsBinding.instance.window.viewInsets,
        WidgetsBinding.instance.window.devicePixelRatio);
    return BlocProvider(
      lazy: false,
      create: (context) => CommentBloc(getIt(), getIt())
        ..add(LoadCommentEvent(postId: widget.post.postId)),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ChangeNotifierProvider(
          create: (context) => ListComments()..initial([]),
          child: BlocListener<CommentBloc, CommentState>(
            listenWhen: (previous, current) =>
                previous.newComment != current.newComment,
            listener: (context, state) {
              context.read<ListComments>().deleteFirst();
              context.read<ListComments>().addFirst(state.newComment!);
            },
            child: Stack(
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 9.6 / 10,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        Header(
                          type: widget.type,
                          isFromDark: widget.isFromDark,
                          post: widget.post,
                          postIndex: widget.index,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          // height: isShowKeyboard
                          //     ? MediaQuery.of(context).size.height * 8.4 / 10 -
                          //         viewInsets.bottom
                          //     : MediaQuery.of(context).size.height * 8.4 / 10,
                          height:
                              MediaQuery.of(context).size.height * 8.4 / 10 -
                                  viewInsets.bottom,
                          child: BlocBuilder<CommentBloc, CommentState>(
                            builder: (context, state) {
                              if (state.status == CommentStatus.loading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (state.status == CommentStatus.loadedFailure) {
                                return const Center(
                                  child: Center(
                                    child: Text(
                                        'To be first person comment this post!'),
                                  ),
                                );
                              }
                              if (state.status == CommentStatus.loadedSuccess) {
                                return Consumer<ListComments>(
                                    builder: (context, value, child) {
                                  context
                                      .read<ListComments>()
                                      .initial(state.itemList);
                                  return ListView.separated(
                                      controller: _scrollController,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                            height: 16,
                                          ),
                                      itemCount: value.items.length,
                                      itemBuilder: (context, index) =>
                                          CommentItem(
                                              comment: value.items[index]));
                                });
                              }
                              return const Center(
                                child: Text('Something went wrong!!!'),
                              );
                            },
                          ),
                        )
                      ],
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 1,
                      color: Colors.black45,
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          color: Colors.white,
                          child: BlocBuilder<CommentBloc, CommentState>(
                            builder: (context2, state) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Focus(
                                      onFocusChange: (_) async {
                                        if (isShowKeyboard) {
                                          await Future.delayed(const Duration(
                                              milliseconds: 150));
                                          isShowKeyboard = false;
                                        } else {
                                          isShowKeyboard = true;
                                        }
                                      },
                                      child: Container(
                                        height: 44,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.4),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(40))),
                                        child: TextField(
                                          controller: _controller,
                                          onChanged: (value) {},
                                          keyboardType: TextInputType.text,
                                          minLines: 1,
                                          maxLines: 4,
                                          autofocus: widget.focus,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 12),
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                            hintText: "Write your comment...",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<ListPostNotify>()
                                          .commentOnPost(
                                              widget.index, widget.type);
                                      BlocProvider.of<CommentBloc>(context2)
                                          .add(AddComment(
                                              content: _controller.text,
                                              postId: widget.post.postId));
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      context2.read<ListComments>().addFirst(
                                          Comment(
                                              userName: userName,
                                              time: 'Commenting...',
                                              content: _controller.text));
                                      _controller.clear();
                                    },
                                    child: const Icon(
                                      Icons.send,
                                      color: Colors.blue,
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.post,
    required this.postIndex,
    required this.isFromDark,
    required this.type,
  }) : super(key: key);

  final Post post;
  final int postIndex;
  final bool isFromDark;
  final PostType type;

  @override
  Widget build(BuildContext context) {
    var likeStyle = const TextStyle(fontWeight: FontWeight.bold);
    return ChangeNotifierProvider<LikeState>(
      create: (context) => LikeState()..initial(post.isSelfLiking),
      child: Consumer<ListPostNotify>(
        builder: (context, value, child) {
          List<Post> items;
          switch (type) {
            case PostType.home:
              items = value.itemsHome;
              break;
            case PostType.profile:
              items = value.itemsProfile;
              break;
            case PostType.search:
              items = value.itemsSearch;
              break;
            case PostType.video:
              items = value.itemsVideo;
              break;
            default:
              items = value.itemsHome;
          }
          var model = items[postIndex];
          return Container(
            padding: EdgeInsets.only(bottom: 16, top: isFromDark ? 16 : 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/icon_like_fix.png',
                          width: 24, height: 24),
                      const SizedBox(width: 4),
                      Text(value.likeText(postIndex, type), style: likeStyle)
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        value.likeOnPost(postIndex, type);
                        getIt<LikeBloc>()
                            .add(AddLikeEvent(postId: post.postId));
                      },
                      child: model.isSelfLiking
                          ? Image.asset('assets/images/icon_liked.png',
                              width: 30, height: 30)
                          : Image.asset('assets/images/icon_like_black.png',
                              width: 26, height: 30))
                ]),
          );
        },
      ),
    );
  }
}

class LikeState with ChangeNotifier {
  late bool isLiked;

  void initial(bool value) {
    isLiked = value;
    notifyListeners();
  }

  void changeState(BuildContext context, int index, PostType type) {
    context.read<ListPostNotify>().likeOnPost(index, type);
    isLiked = !isLiked;
    notifyListeners();
  }
}

class ListComments with ChangeNotifier {
  late List<Comment> items = [];

  void initial(List<Comment> items) {
    this.items = items;
  }

  void addFirst(Comment comment) {
    items.insert(0, comment);
    notifyListeners();
  }

  void deleteFirst() {
    items.removeAt(0);
    notifyListeners();
  }
}
