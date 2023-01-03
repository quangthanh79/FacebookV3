import 'dart:io';

import 'package:flutter/widgets.dart';

Image getImage({
  File? file,
  String? uri,
  String defaultUri = 'assets/images/default_avatar_image.jpg',
  double? width,
  double? height,
}){
  if (file != null){
    return Image.file(
      file,
      fit: BoxFit.fill,
      width: width,
      height: height,
    );
  }
  final httpRegex = RegExp(r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$');
  if (uri != null){
    if (httpRegex.hasMatch(uri)){
      return Image.network(
        uri,
        fit: BoxFit.fill,
        width: width,
        height: height,
      );
    } else {
      return Image.asset(
        uri,
        fit: BoxFit.fill,
        width: width,
        height: height,
      );
    }
  }
  return Image.asset(
    defaultUri,
    fit: BoxFit.fill,
    width: width,
    height: height,
  );
}