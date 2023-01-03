// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class NetworkVideo extends StatefulWidget {
  const NetworkVideo({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<NetworkVideo> createState() => _NetworkVideoState();
}

class _NetworkVideoState extends State<NetworkVideo> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.url),
      autoPlay: false,
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: const Key('my-widget-key'),
        onVisibilityChanged: (info) {
          if (info.matchesVisibility(info)) {
            flickManager.flickControlManager!.play();
          } else {
            flickManager.flickControlManager!.pause();
          }
        },
        child: FlickVideoPlayer(flickManager: flickManager));
  }
}
