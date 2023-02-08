import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

enum ImageListType { network, file }

extension ImageListTypeX on ImageListType {
  bool get isNetwork => this == ImageListType.network;
  bool get isFile => this == ImageListType.file;
}

class ImageViewBeautiful extends StatelessWidget {
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
  Widget build(BuildContext context) {
    int numberImage = 0;
    if (itemsFile == null && itemsNetwork == null) {
      return Container();
    }
    if (imageListType.isNetwork) {
      numberImage = itemsNetwork!.length;
    } else if (imageListType.isFile) {
      numberImage = itemsFile!.length;
    } else {
      return Container();
    }
    if (numberImage > 4) {
      return SizedBox(
        height: 352,
        child: GridView.custom(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
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
            (context, index) => index < 4
                ? (index == 3
                    ? Stack(
                        children: [
                          buildImage(index),
                          Positioned.fill(
                              child: Container(
                            color: Colors.black.withOpacity(0.3),
                            child: const Icon(
                              Icons.add,
                              size: 44,
                            ),
                          ))
                        ],
                      )
                    : buildImage(index))
                : null,
          ),
        ),
      );
    }
    switch (numberImage) {
      case 1:
        return imageListType.isNetwork
            ? Image.network(itemsNetwork![0], fit: BoxFit.contain)
            : Image.file(
                itemsFile![0],
                fit: BoxFit.contain,
              );

      case 2:
        return SizedBox(
          height: 180,
          child: GridView.custom(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
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
          ),
        );
      case 3:
        return SizedBox(
          height: 352,
          child: GridView.custom(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
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
          ),
        );
      case 4:
        return SizedBox(
          height: 352,
          child: GridView.custom(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
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
          ),
        );
      default:
        return Container();
    }
  }

  Widget buildImage(int index) {
    return imageListType.isNetwork
        ? Image.network(
            itemsNetwork![index],
            fit: BoxFit.cover,
          )
        : Image.file(
            itemsFile![index],
            fit: BoxFit.cover,
          );
  }
}
