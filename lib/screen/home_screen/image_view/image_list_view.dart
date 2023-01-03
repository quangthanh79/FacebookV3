// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

enum ImageListType { network, file }

extension ImageListTypeX on ImageListType {
  bool get isNetwork => this == ImageListType.network;
  bool get isFile => this == ImageListType.file;
}

class ImageListView extends StatelessWidget {
  final List<String>? itemsNetwork;
  final List<File>? itemsFile;
  final ImageListType imageListType;

  const ImageListView({
    Key? key,
    this.itemsNetwork,
    this.itemsFile,
    required this.imageListType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageListType.isNetwork && itemsNetwork != null) {
      return SizedBox(
        height: 280,
        child: itemsNetwork!.length == 1
            ? Container(
                alignment: Alignment.center,
                child: Image.network(
                  itemsNetwork![0],
                  fit: BoxFit.fitHeight,
                ))
            : ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: itemsNetwork!.length,
                separatorBuilder: (context, index) => Container(
                  width: 12,
                  color: Colors.white,
                ),
                itemBuilder: (context, index) {
                  return Image.network(
                    itemsNetwork![index],
                    fit: BoxFit.fitHeight,
                  );
                },
              ),
      );
    }
    if (imageListType.isFile && itemsFile != null) {
      return SizedBox(
        height: 280,
        child: itemsFile!.length == 1
            ? Container(
                alignment: Alignment.center,
                child: Image.file(
                  itemsFile![0],
                  fit: BoxFit.fitHeight,
                ))
            : ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: itemsFile!.length,
                separatorBuilder: (context, index) => Container(
                  width: 12,
                  color: Colors.white,
                ),
                itemBuilder: (context, index) {
                  return Image.file(
                    itemsFile![index],
                    fit: BoxFit.fitHeight,
                  );
                },
              ),
      );
    }
    return Container();
  }
}
