import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key, required this.path});

  final String path;
  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _playerController;
  ChewieController? controller;


  

  Future<void> init() async {
    _playerController = VideoPlayerController.file(
      File(widget.path),
    );
    
    await _playerController.initialize();
    controller = ChewieController(
      videoPlayerController: _playerController,
      autoPlay: true,
      looping: false,
      
      // deviceOrientationsAfterFullScreen: [
      //   DeviceOrientation.portraitUp,
      //   DeviceOrientation.portraitDown,
      // ],
    );
    setState(() {});
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {

    controller?.dispose();
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  controller != null
          ? Chewie(controller: controller!)
          : const Center(
              child: CircularProgressIndicator(),
            )
    ;
  }
}
