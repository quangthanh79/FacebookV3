// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_post_bloc.dart';

abstract class AddPostEvent extends Equatable {
  const AddPostEvent();

  @override
  List<Object> get props => [];
}

class PickImage extends AddPostEvent {
  final File image;
  final bool isImage;
  const PickImage({
    required this.image,
    required this.isImage,
  });

  @override
  List<Object> get props => [image, isImage];

  PickImage copyWith({
    File? image,
    bool? isImage,
  }) {
    return PickImage(
      image: image ?? this.image,
      isImage: isImage ?? this.isImage,
    );
  }
}

class PickVideo extends AddPostEvent {
  final File video;
  final bool isImage;
  const PickVideo({
    required this.video,
    required this.isImage,
  });

  @override
  List<Object> get props => [video, isImage];

  PickVideo copyWith({
    File? video,
    bool? isImage,
  }) {
    return PickVideo(
      video: video ?? this.video,
      isImage: isImage ?? this.isImage,
    );
  }
}

class AddPost extends AddPostEvent {
  final BuildContext context;
  const AddPost({
    required this.context,
  });
  @override
  List<Object> get props => [context];
}

class PostContentChange extends AddPostEvent {
  final String content;
  const PostContentChange({
    required this.content,
  });
  @override
  List<Object> get props => [content];
}

class StartPickImage extends AddPostEvent {}

class StartPickVideo extends AddPostEvent {}
