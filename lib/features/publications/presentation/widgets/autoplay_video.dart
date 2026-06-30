import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AutoplayVideo extends StatefulWidget {
  final String url;
  const AutoplayVideo({super.key, required this.url});

  @override
  State<AutoplayVideo> createState() => _AutoplayVideoState();
}

class _AutoplayVideoState extends State<AutoplayVideo> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) {
        if (mounted) {
          setState(() => _isInitialized = true);
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.url),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.8) {
          _controller.play();
        } else {
          _controller.pause();
        }
      },
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: _isInitialized
            ? VideoPlayer(_controller)
            : Container(
                color: Colors.grey[200],
                child: const Center(child: CircularProgressIndicator()),
              ),
      ),
    );
  }
}
