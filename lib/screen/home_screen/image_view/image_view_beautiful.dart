import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

enum ImageListType { network, file }

extension ImageListTypeX on ImageListType {
  bool get isNetwork => this == ImageListType.network;
  bool get isFile => this == ImageListType.file;
}

class ImageViewBeautiful extends StatefulWidget {
  final List<String>? itemsNetwork;
  final List<File>? itemsFile;
  final ImageListType imageListType;

  const ImageViewBeautiful({
    Key? key,
    this.itemsNetwork,
    this.itemsFile,
    required this.imageListType,
  }) : super(key: key);

  @override
  State<ImageViewBeautiful> createState() => _ImageViewBeautifulState();
}

class _ImageViewBeautifulState extends State<ImageViewBeautiful> {
  @override
  Widget build(BuildContext context) {
    int numberImage = 0;
    if (widget.imageListType.isNetwork) {
      numberImage = widget.itemsNetwork!.length;
    } else if (widget.imageListType.isFile) {
      numberImage = widget.itemsFile!.length;
    } else {
      return Container();
    }
    switch (numberImage) {
      case 1:
        return widget.imageListType.isNetwork
            ? Image.network(widget.itemsNetwork![0], fit: BoxFit.contain)
            : Image.file(
                widget.itemsFile![0],
                fit: BoxFit.contain,
              );

      case 2:
        return GridView.custom(
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            repeatPattern: QuiltedGridRepeatPattern.inverted,
            pattern: [
              const QuiltedGridTile(1, 1),
              const QuiltedGridTile(1, 1),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => index < 2 ? buildImage(index) : null,
          ),
        );
      case 3:
        return GridView.custom(
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            repeatPattern: QuiltedGridRepeatPattern.inverted,
            pattern: [
              const QuiltedGridTile(1, 1),
              const QuiltedGridTile(1, 1),
              const QuiltedGridTile(1, 2),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => index < 3 ? buildImage(index) : null,
          ),
        );
      case 4:
        return GridView.custom(
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            repeatPattern: QuiltedGridRepeatPattern.inverted,
            pattern: [
              const QuiltedGridTile(1, 1),
              const QuiltedGridTile(1, 1),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => index < 4 ? buildImage(index) : null,
          ),
        );
      default:
        return Container();
    }
  }

  Widget buildImage(int index) {
    return widget.imageListType.isNetwork
        ? Image.network(
            widget.itemsNetwork![index],
            fit: BoxFit.cover,
          )
        : Image.file(
            widget.itemsFile![index],
            fit: BoxFit.cover,
          );
  }
}
