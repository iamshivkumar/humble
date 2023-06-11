import 'package:flutter/material.dart';
import 'package:humble/ui/chat/widgets/video_player_widget.dart';

class VideoPlayerPage extends StatelessWidget {
  const VideoPlayerPage({super.key, required this.path});
  final String path;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: VideoPlayerWidget(path: path),
    );
  }
}
