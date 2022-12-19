// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/screen/home_screen/comment_list/comment_list_view.dart';
import 'package:facebook_auth/screen/home_screen/home_body.dart';
import 'package:facebook_auth/screen/home_screen/post_in_image_screen/post_in_image_screen.dart';
import 'package:facebook_auth/screen/home_screen/post_item/bloc/post_item_bloc.dart';
import 'package:facebook_auth/screen/user_screen/user_screen.dart';
import 'package:facebook_auth/utils/constant.dart';
import 'package:facebook_auth/utils/injection.dart';

import '../like_bloc/like_bloc.dart';
import '../model/comment.dart';
import '../model/post.dart';

class PostItem extends StatelessWidget {
  final Post post;
  final int index;
  const PostItem({
    Key? key,
    required this.post,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostItemBloc()..add(PostInitEvent(isSelfLiking: post.isSelfLiking)),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Header(post: post)),
          const SizedBox(
            height: 4,
          ),
          Content(
            post: post,
            postIndex: index,
          ),
          const SizedBox(
            height: 8,
          ),
          Bottom(
            isFromDark: false,
            postIndex: index,
            textColor: Colors.black,
          )
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final Post post;
  const Header({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            User user = User(
                id: post.user_id,
                avatar: post.avatarUrl,
                username: post.userName);
            // Navigate to UserScreen
            Navigator.push(context, UserScreen.route(user: user));
          },
          child: Row(
            children: [
              post.avatarUrl != null
                  ? CircleAvatar(
                      radius: 16.0,
                      backgroundImage: NetworkImage(
                        post.avatarUrl!,
                      ),
                      backgroundColor: Colors.transparent,
                    )
                  : Image.asset(
                      defaultAvatar,
                      width: 32,
                      height: 32,
                    ),
              const SizedBox(
                width: 6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      post.userName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(post.time,
                      style: const TextStyle(
                        fontSize: 12,
                      ))
                ],
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context2) => Dialog(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context2);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Report post success!")));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.report),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Report this post'),
                          Spacer()
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Image.asset(
              'assets/images/menu_3_dots.png',
              width: 24,
              height: 24,
            ),
          ),
        )
      ],
    );
  }
}

class Content extends StatelessWidget {
  final Post post;
  final int postIndex;
  const Content({
    Key? key,
    required this.post,
    required this.postIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ContentText(
              content: post.content,
              textColor: Colors.black,
            )),
        const SizedBox(
          height: 8,
        ),
        AssetsContent(
          post: post,
          postIndex: postIndex,
        )
      ],
    );
  }
}

class AssetsContent extends StatelessWidget {
  final Post post;
  final int postIndex;
  const AssetsContent({
    Key? key,
    required this.post,
    required this.postIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (post.assetType != null && post.assetType == TYPE_IMAGE) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          height: 300,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostInImageScreen(
                      index: postIndex,
                    ),
                  ));
            },
            child: Image.network(
              post.assetContentUrl![0],
              fit: BoxFit.cover,
            ),
          ));
    }
    return Container();
  }
}

class Bottom extends StatelessWidget {
  final Color textColor;
  final bool? isDarkTheme;
  final int postIndex;
  final bool isFromDark;
  const Bottom({
    Key? key,
    required this.textColor,
    this.isDarkTheme,
    required this.postIndex,
    required this.isFromDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String likeIconPath = 'assets/images/icon_like_black.png';
    if (isDarkTheme != null && isDarkTheme == true) {
      likeIconPath = 'assets/images/icon_like.png';
    }
    String commentIconPath = 'assets/images/comment_icon.png';
    if (isDarkTheme != null && isDarkTheme == true) {
      commentIconPath = 'assets/images/comment_icon_white.png';
    }
    var post = context.read<ListPostNotify>().items[postIndex];
    return Consumer<ListPostNotify>(
      builder: (context, value, child) => Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Image.asset(
                    'assets/images/icon_like_fix.png',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(context.read<ListPostNotify>().likeText(postIndex),
                      style: TextStyle(color: textColor))
                ]),
                BlocBuilder<PostItemBloc, PostItemState>(
                    builder: (context, state) => GestureDetector(
                          onTap: () async {
                            showBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                ),
                                builder: (context) => CommentListView(
                                      isFromDark: isFromDark,
                                      post: context
                                          .read<ListPostNotify>()
                                          .items[postIndex],
                                      focus: false,
                                      comments: Comment.fakeList,
                                      index: postIndex,
                                    ));
                          },
                          child: Text(
                            '${post.commentsNumber} comments',
                            style: TextStyle(color: textColor),
                          ),
                        ))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            color: Colors.grey,
            height: 1,
            width: double.infinity,
          ),
          Container(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocBuilder<PostItemBloc, PostItemState>(
                    builder: (context, state) => GestureDetector(
                          onTap: () {
                            context
                                .read<ListPostNotify>()
                                .likeOnPost(postIndex);
                            getIt<LikeBloc>()
                                .add(AddLikeEvent(postId: post.postId));
                          },
                          child: Consumer<ListPostNotify>(
                            builder: (context, value, child) {
                              var post = value.items[postIndex];
                              return Row(
                                children: [
                                  Image.asset(
                                    post.isSelfLiking
                                        ? 'assets/images/icon_liked.png'
                                        : likeIconPath,
                                    width: 20,
                                    height: 20,
                                  ),
                                  Text(' Like',
                                      style: TextStyle(
                                          color: post.isSelfLiking
                                              ? Colors.blue
                                              : textColor))
                                ],
                              );
                            },
                          ),
                        )),
                GestureDetector(
                  onTap: () async {
                    showBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                        builder: (context2) => CommentListView(
                              isFromDark: isFromDark,
                              post: post,
                              focus: true,
                              comments: Comment.fakeList,
                              index: postIndex,
                            ));
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        commentIconPath,
                        width: 20,
                        height: 20,
                      ),
                      Text(' Comment', style: TextStyle(color: textColor))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ContentText extends StatefulWidget {
  final String content;
  final Color textColor;
  final Color? showMoreColor;
  final VoidCallback? voidCallback;
  const ContentText({
    Key? key,
    required this.content,
    required this.textColor,
    this.showMoreColor,
    this.voidCallback,
  }) : super(key: key);

  @override
  State<ContentText> createState() => _ContentTextState();
}

class _ContentTextState extends State<ContentText> {
  bool isShowMore = false;
  @override
  Widget build(BuildContext context) {
    if (widget.content.length > MAX_LENGTH_TEXT && isShowMore == false) {
      return RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          style: TextStyle(
            fontSize: 14.0,
            color: widget.textColor,
          ),
          children: <TextSpan>[
            TextSpan(
                text: '${widget.content.substring(0, MAX_LENGTH_TEXT - 1)}...'),
            TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      isShowMore = true;
                      widget.voidCallback?.call();
                    });
                  },
                text: 'Show more',
                style:
                    TextStyle(color: widget.showMoreColor ?? Colors.black54)),
          ],
        ),
      );
    }
    if (isShowMore == true) {
      return Text(widget.content,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14.0,
            color: widget.textColor,
          ));
    }
    return Text(widget.content,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 14.0,
          color: widget.textColor,
        ));
  }
}
