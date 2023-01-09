// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

enum ImageListType { network, file }

extension ImageListTypeX on ImageListType {
  bool get isNetwork => this == ImageListType.network;
  bool get isFile => this == ImageListType.file;
}

class ImageListView extends StatefulWidget {
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
  State<ImageListView> createState() => _ImageListViewState();
}

class _ImageListViewState extends State<ImageListView> {
  bool isValid = true;
  @override
  Widget build(BuildContext context) {
    if (widget.imageListType.isNetwork && widget.itemsNetwork != null) {
      return SizedBox(
        height: widget.itemsNetwork!.length == 1
            ? null
            : isValid
                ? 280
                : 0,
        child: widget.itemsNetwork!.length == 1
            ? Container(
                alignment: Alignment.center,
                child: Image.network(
                  widget.itemsNetwork![0],
                  fit: BoxFit.fitHeight,
                  errorBuilder: (context, error, stackTrace) {
                    Future.delayed(
                        const Duration(milliseconds: 500),
                        () => setState(() {
                              isValid = false;
                            }));
                    return const SizedBox.shrink();
                  },
                ))
            : ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.itemsNetwork!.length,
                separatorBuilder: (context, index) => Container(
                  width: 12,
                  color: Colors.white,
                ),
                itemBuilder: (context, index) {
                  return Image.network(
                    widget.itemsNetwork![index],
                    fit: BoxFit.fitHeight,
                  );
                },
              ),
      );
    }
    if (widget.imageListType.isFile && widget.itemsFile != null) {
      return SizedBox(
        height: 280,
        child: widget.itemsFile!.length == 1
            ? Container(
                alignment: Alignment.center,
                child: Image.file(
                  widget.itemsFile![0],
                  fit: BoxFit.fitHeight,
                ))
            : ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.itemsFile!.length,
                separatorBuilder: (context, index) => Container(
                  width: 12,
                  color: Colors.white,
                ),
                itemBuilder: (context, index) {
                  return Image.file(
                    widget.itemsFile![index],
                    fit: BoxFit.fitHeight,
                  );
                },
              ),
      );
    }
    return Container();
  }
}
