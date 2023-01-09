// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_post_bloc.dart';

abstract class AddPostEvent extends Equatable {
  const AddPostEvent();

  @override
  List<Object?> get props => [];
}

class EditPostEvent extends AddPostEvent {
  final List<File>? images;
  final File? video;
  final AddPostType? addPostType;
  final String? content;
  const EditPostEvent({
    this.images,
    this.video,
    this.addPostType,
    this.content,
  });

  EditPostEvent copyWith({
    List<File>? images,
    File? video,
    AddPostType? addPostType,
    String? content,
  }) {
    return EditPostEvent(
      images: images ?? this.images,
      video: video ?? this.video,
      addPostType: addPostType ?? this.addPostType,
      content: content ?? this.content,
    );
  }
}

class PickImage extends AddPostEvent {
  final List<File>? images;
  const PickImage({
    this.images,
  });

  @override
  List<Object?> get props => [images];

  PickImage copyWith({
    List<File>? images,
  }) {
    return PickImage(
      images: images ?? this.images,
    );
  }
}

class PickVideo extends AddPostEvent {
  final File? video;
  const PickVideo({
    this.video,
  });

  @override
  List<Object?> get props => [video];

  PickVideo copyWith({
    File? video,
    bool? isImage,
  }) {
    return PickVideo(
      video: video ?? this.video,
    );
  }
}

class AddPost extends AddPostEvent {
  final BuildContext context;
  final String? id;
  const AddPost({
    required this.context,
    this.id,
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
