// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_post_bloc.dart';

abstract class AddPostEvent extends Equatable {
  const AddPostEvent();

  @override
  List<Object> get props => [];
}

class PickImage extends AddPostEvent {
  final File image;
  const PickImage({
    required this.image,
  });

  PickImage copyWith({
    File? image,
  }) {
    return PickImage(
      image: image ?? this.image,
    );
  }

  @override
  List<Object> get props => [image];
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
