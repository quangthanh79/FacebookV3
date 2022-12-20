// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/screen/user_screen/user_screen.dart';
import 'package:facebook_auth/utils/constant.dart';
import 'package:flutter/material.dart';

import 'package:facebook_auth/screen/home_screen/model/comment.dart';
import 'package:facebook_auth/screen/home_screen/post_item/post_item.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;
  const CommentItem({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
            child: comment.avatarUrl != null
                ? CircleAvatar(
                    radius: 16.0,
                    backgroundImage: NetworkImage(
                      comment.avatarUrl!,
                    ),
                    backgroundColor: Colors.transparent,
                  )
                : Image.asset(
                    defaultAvatar,
                    width: 32,
                    height: 32,
                  ),
            onTap: () {
              User user = User(
                  id: comment.user_id,
                  avatar: comment.avatarUrl,
                  username: comment.userName);
              // Navigate to UserScreen
              Navigator.push(context, UserScreen.route(user: user));
            }),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommentCard(
                comment: comment,
              ),
              Container(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  comment.time,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class CommentCard extends StatelessWidget {
  final Comment comment;
  const CommentCard({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.black12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
            child: Text(
              comment.userName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              User user = User(
                  id: comment.user_id,
                  avatar: comment.avatarUrl,
                  username: comment.userName);
              // Navigate to UserScreen
              Navigator.push(context, UserScreen.route(user: user));
            }),
        const SizedBox(
          height: 4,
        ),
        ContentText(content: comment.content, textColor: Colors.black)
      ]),
    );
  }
}
