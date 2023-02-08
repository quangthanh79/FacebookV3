// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:facebook_auth/core/helper/app_helper.dart';
import 'package:facebook_auth/core/helper/current_user.dart';
import 'package:facebook_auth/domain/use_cases/like_use_case%20copy.dart';
import 'package:facebook_auth/screen/home_screen/add_post/add_post_screen.dart';
import 'package:facebook_auth/screen/home_screen/add_post/bloc/add_post_bloc.dart';
import 'package:facebook_auth/screen/home_screen/image_view/image_view_beautiful.dart';
import 'package:facebook_auth/screen/home_screen/video_view/network_video.dart';
import 'package:facebook_auth/utils/session_user.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/post_repository_impl.dart';
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
  const PostItem({
    Key? key,
    required this.post,
    required this.index,
    required this.type,
  }) : super(key: key);

  final int index;
  final Post post;
  final PostType type;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostItemBloc()..add(PostInitEvent(isSelfLiking: post.isSelfLiking)),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Header(
                post: post,
                index: index,
                type: type,
              )),
          const SizedBox(
            height: 4,
          ),
          Content(
            type: type,
            post: post,
            postIndex: index,
          ),
          const SizedBox(
            height: 8,
          ),
          Bottom(
            type: type,
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
  const Header({
    Key? key,
    required this.index,
    required this.post,
    required this.type,
  }) : super(key: key);

  final int index;
  final Post post;
  final PostType type;

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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        post.user_id == CurrentUser.id
                            ? Column(mainAxisSize: MainAxisSize.min, children: [
                                GestureDetector(
                                  onTap: () async {
                                    var images, video, _type = AddPostType.none;
                                    if (post.assetType == TYPE_IMAGE) {
                                      _type = AddPostType.image;
                                      images = await Future.wait(
                                          post.assetContentUrl!.map((e) =>
                                              getFileFromNetwork(url: e)));
                                    }
                                    if (post.assetType == TYPE_VIDEO) {
                                      _type = AddPostType.video;
                                      video = await getFileFromNetwork(
                                          url: post.assetContentUrl![0]);
                                    }
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddPostView(
                                            postType: type,
                                            editIndex: index,
                                            isEditing: true,
                                            id: post.postId,
                                            addPostType: _type,
                                            content: post.content,
                                            images: images,
                                            video: video,
                                            likesNumber: post.likesNumber,
                                            commentsNumber: post.commentsNumber,
                                            isSelfLiking: post.isSelfLiking,
                                          ),
                                        ));
                                    Navigator.pop(context2);
                                    // getIt<DeletePostUseCase>().call(DeletePostParams(
                                    //     token: SessionUser.token!,
                                    //     postId: post.postId));
                                    // context
                                    //     .read<ListPostNotify>()
                                    //     .deletePost(index, type);
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: const [
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(Icons.edit),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Edit this post',
                                        style: BOLD_STYLE,
                                      ),
                                      Spacer()
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDeleteDialog(
                                      context,
                                      title: 'DELETE WARNING',
                                      content: 'Do you want delete this post?',
                                      onYesClick: () {
                                        getIt<DeletePostUseCase>().call(
                                            DeletePostParams(
                                                token: SessionUser.token!,
                                                postId: post.postId));
                                        context
                                            .read<ListPostNotify>()
                                            .deletePost(index, type);
                                        Navigator.pop(context2);
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                          "Delete post success!",
                                          style: BOLD_STYLE,
                                        )));
                                      },
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: const [
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Delete this post',
                                        style: BOLD_STYLE,
                                      ),
                                      Spacer()
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ])
                            : Container(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context2);
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Text(
                              "Report post success!",
                              style: BOLD_STYLE,
                            )));
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
                              Text(
                                'Report this post',
                                style: BOLD_STYLE,
                              ),
                              Spacer()
                            ],
                          ),
                        ),
                      ],
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
  const Content({
    Key? key,
    required this.post,
    required this.postIndex,
    required this.type,
  }) : super(key: key);

  final Post post;
  final int postIndex;
  final PostType type;

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
          type: type,
          post: post,
          postIndex: postIndex,
        )
      ],
    );
  }
}

class AssetsContent extends StatelessWidget {
  const AssetsContent({
    Key? key,
    required this.post,
    required this.postIndex,
    required this.type,
  }) : super(key: key);

  final Post post;
  final int postIndex;
  final PostType type;

  @override
  Widget build(BuildContext context) {
    if (post.assetType != null && post.assetType == TYPE_IMAGE) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostInImageScreen(
                  type: type,
                  index: postIndex,
                ),
              ));
        },
        child: ImageViewBeautiful(
          imageListType: ImageListType.network,
          itemsNetwork: post.assetContentUrl,
        ),
      );
    }
    if (post.assetType != null && post.assetType == TYPE_VIDEO) {
      return NetworkVideo(url: post.assetContentUrl![0]);
    }
    return Container();
  }
}

class Bottom extends StatelessWidget {
  const Bottom({
    Key? key,
    required this.textColor,
    this.isDarkTheme,
    required this.postIndex,
    required this.isFromDark,
    required this.type,
  }) : super(key: key);

  final bool? isDarkTheme;
  final bool isFromDark;
  final int postIndex;
  final Color textColor;
  final PostType type;

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
    return Consumer<ListPostNotify>(builder: (context, value, child) {
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
      var post = items[postIndex];
      return Column(
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
                  Text(context.read<ListPostNotify>().likeText(postIndex, type),
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
                                      type: type,
                                      isFromDark: isFromDark,
                                      post: items[postIndex],
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
                                .likeOnPost(postIndex, type);
                            getIt<LikeBloc>()
                                .add(AddLikeEvent(postId: post.postId));
                          },
                          child: Consumer<ListPostNotify>(
                            builder: (context, value, child) {
                              var post = items[postIndex];
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
                              type: type,
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
      );
    });
  }
}

class ContentText extends StatefulWidget {
  const ContentText({
    Key? key,
    required this.content,
    required this.textColor,
    this.showMoreColor,
    this.voidCallback,
  }) : super(key: key);

  final String content;
  final Color? showMoreColor;
  final Color textColor;
  final VoidCallback? voidCallback;

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
