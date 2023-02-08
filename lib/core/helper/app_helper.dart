// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<File> getFileFromNetwork({required String url}) async {
  /// Get Image from server
  final Response res = await Dio().get<List<int>>(
    url,
    options: Options(
      responseType: ResponseType.bytes,
    ),
  );

  /// Get App local storage
  final Directory appDir = await getApplicationDocumentsDirectory();

  /// Generate Image Name
  final String fileName = url.split('/').last;

  /// Create Empty File in app dir & fill with new file
  final File file = File(join(appDir.path, fileName));

  file.writeAsBytesSync(res.data as List<int>);

  return file;
}

const TextStyle BOLD_STYLE =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

showDeleteDialog(BuildContext context,
    {String? title, String? content, VoidCallback? onYesClick}) {
  showDialog(
      context: context,
      builder: (BuildContext contextPopup) {
        return AlertDialog(
          title: Text(title ?? 'Please Confirm'),
          content: Text(content ?? 'Are you sure to remove the box?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(contextPopup).pop();
                },
                child: const Text('No')),
            TextButton(
                onPressed: () {
                  onYesClick?.call();
                  Navigator.of(contextPopup).pop();
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),
                )),
          ],
        );
      });
}

/// Helper class for device related operations.
///
class DeviceHelper {
  ///
  /// hides the keyboard if its already open
  ///
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static double screenSizeHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenSizeHeightNotIncludeStatusBar(BuildContext context) {
    return MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top;
  }

  static double screenSizeWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// orientation
  ///
  static double getScaledSize(BuildContext context, double scale) =>
      scale *
      (MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.height);

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// width
  ///
  static double getScaledWidth(BuildContext context, double scale) =>
      scale * MediaQuery.of(context).size.width;

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// height
  ///
  static double getScaledHeight(BuildContext context, double scale) =>
      scale * MediaQuery.of(context).size.height;

  SizedBox addPaddingWhenKeyboardAppears() {
    final viewInsets = EdgeInsets.fromWindowPadding(
      WidgetsBinding.instance.window.viewInsets,
      WidgetsBinding.instance.window.devicePixelRatio,
    );

    final bottomOffset = viewInsets.bottom;
    const hiddenKeyboard = 0.0; // Always 0 if keyboard is not opened
    final isNeedPadding = bottomOffset != hiddenKeyboard;

    return SizedBox(height: isNeedPadding ? bottomOffset : hiddenKeyboard);
  }
}
