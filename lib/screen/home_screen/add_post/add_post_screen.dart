// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:facebook_auth/screen/home_screen/image_view/image_view_beautiful.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:facebook_auth/core/helper/current_user.dart';
import 'package:facebook_auth/screen/home_screen/video_view/video_demo.dart';
import 'package:facebook_auth/utils/constant.dart';
import 'package:facebook_auth/utils/injection.dart';

import 'bloc/add_post_bloc.dart';

class AddPostView extends StatefulWidget {
  final bool isEditing;
  final String? id;
  final List<File>? images;
  final File? video;
  final AddPostType? addPostType;
  final String? content;
  const AddPostView({
    Key? key,
    required this.isEditing,
    this.id,
    this.images,
    this.video,
    this.addPostType,
    this.content,
  }) : super(key: key);

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  late TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController =
        TextEditingController(text: widget.isEditing ? widget.content : '');
    super.initState();
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                widget.isEditing ? 'Edit post' : 'Create post',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
          ElevatedButton(
              onPressed: () {
                if (context.read<AddPostBloc>().state.content != '') {
                  context.read<AddPostBloc>().add(AddPost(
                      context: context,
                      id: widget.isEditing ? widget.id : null));
                }
              },
              child: const Text("POST"))
        ],
      ),
    );
  }

  Widget buildBody() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CurrentUser.avatar != null
                  ? CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        CurrentUser.avatar!,
                      ),
                      backgroundColor: Colors.transparent,
                    )
                  : Image.asset(
                      defaultAvatar,
                      scale: 30,
                    ),
              const SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(CurrentUser.userName ?? 'Facebook user',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/global.png',
                            scale: 4,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const Text("Global"),
                        ],
                      ))
                ],
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
              child: BlocBuilder<AddPostBloc, AddPostState>(
            buildWhen: (previous, current) =>
                previous.addPostType != current.addPostType,
            builder: (contextBloc, state) {
              return Column(
                children: [
                  TextField(
                    controller: textEditingController,
                    onChanged: (value) {
                      contextBloc
                          .read<AddPostBloc>()
                          .add(PostContentChange(content: value));
                    },
                    maxLength: 500,
                    maxLines: null,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      hintText: "What do you think?",
                      hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    alignment: Alignment.topCenter,
                    child: state.addPostType != AddPostType.none
                        ? (state.addPostType != AddPostType.video
                            ? ImageViewBeautiful(
                                imageListType: ImageListType.file,
                                itemsFile: state.images,
                              )
                            : Container(
                                height: 300,
                                padding: const EdgeInsets.all(8),
                                child: VideoDemo(
                                  isFile: state.video,
                                )))
                        : Container(),
                  ))
                ],
              );
            },
          ))
        ],
      ),
    );
  }

  Widget buildBottom(BuildContext context) {
    imagePicked(List<File>? images) =>
        context.read<AddPostBloc>().add(PickImage(images: images));
    videoPicked(File? video) =>
        context.read<AddPostBloc>().add(PickVideo(video: video));
    return Column(
      children: [
        Container(
          height: 1,
          padding: const EdgeInsets.symmetric(vertical: 4),
          color: Colors.black26,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Add to your post',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              BlocBuilder<AddPostBloc, AddPostState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context2) => Dialog(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    Navigator.pop(context2);
                                    final ImagePicker picker = ImagePicker();
                                    List<XFile> images =
                                        await picker.pickMultiImage();
                                    if (images.isNotEmpty) {
                                      List<File> listFile = [];
                                      for (var e in images) {
                                        File file = File(e.path);
                                        listFile.add(file);
                                      }
                                      imagePicked(listFile);
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: const [
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(Icons.image),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text('Add image'),
                                      Spacer()
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    Navigator.pop(context2);
                                    final ImagePicker picker = ImagePicker();
                                    XFile? video = await picker.pickVideo(
                                        source: ImageSource.gallery);
                                    if (video != null) {
                                      var file = File(video.path);
                                      videoPicked(file);
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: const [
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(Icons.video_camera_front),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text('Add video'),
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
                    child: const Icon(
                      Icons.image,
                      color: Colors.greenAccent,
                      size: 36,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddPostBloc>(
      create: (context) => widget.isEditing
          ? (AddPostBloc(getIt(), getIt())
            ..add(EditPostEvent(
                addPostType: widget.addPostType,
                content: widget.content,
                images: widget.images,
                video: widget.video)))
          : AddPostBloc(getIt(), getIt()),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            body: SafeArea(
                child: BlocListener<AddPostBloc, AddPostState>(
          listenWhen: (previous, current) =>
              current.status == AddPostStatus.success,
          listener: (context, state) {
            Navigator.pop(context);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              BlocBuilder<AddPostBloc, AddPostState>(
                builder: (contextBloc, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            buildHeader(contextBloc),
                            Container(
                              height: 1,
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              color: Colors.black26,
                            ),
                            Expanded(child: buildBody())
                          ],
                        ),
                      ),
                      buildBottom(contextBloc)
                    ],
                  );
                },
              ),
              BlocBuilder<AddPostBloc, AddPostState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status,
                builder: (context, state) {
                  if (state.status == AddPostStatus.posting) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        Text('Uploading your post...')
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ))),
      ),
    );
  }
}
