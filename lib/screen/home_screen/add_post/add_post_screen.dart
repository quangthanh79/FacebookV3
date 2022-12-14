import 'dart:io';

import 'package:facebook_auth/screen/home_screen/home_body.dart';
import 'package:facebook_auth/screen/home_screen/model/post.dart';
import 'package:facebook_auth/utils/constant.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'bloc/add_post_bloc.dart';

class AddPostView extends StatelessWidget {
  const AddPostView({super.key});

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
              const Text(
                'Create post',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
          ElevatedButton(
              onPressed: () {
                if (context.read<AddPostBloc>().state.content != '') {
                  context.read<AddPostBloc>().add(AddPost(context: context));
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
              Image.asset(
                defaultAvatar,
                scale: 20,
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(userName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
          Expanded(child: BlocBuilder<AddPostBloc, AddPostState>(
            builder: (context, state) {
              return TextField(
                onChanged: (value) {
                  context
                      .read<AddPostBloc>()
                      .add(PostContentChange(content: value));
                },
                maxLength: 500,
                maxLines: 20,
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
              );
            },
          ))
        ],
      ),
    );
  }

  Widget buildBottom(BuildContext context) {
    imagePicked(File image) =>
        context.read<AddPostBloc>().add(PickImage(image: image));
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
                      final ImagePicker picker = ImagePicker();
                      XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);

                      if (image != null) {
                        imagePicked(File(image.path));
                      }
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
    return BlocProvider(
      create: (context) => AddPostBloc(getIt()),
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
