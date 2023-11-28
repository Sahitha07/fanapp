import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:fan_project/models/news.dart';
import 'package:video_player/video_player.dart';

import '../../mediaStorage/videoCache.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;
  String newsId;
  News news;
  int index;

  VideoPlayerWidget(
      {super.key,
      required this.videoPath,
      required this.newsId,
      required this.news,
      required this.index});
  @override
  Key? get key => UniqueKey();
  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool isControllerInitialized = false;
  ChewieController? _chewieController;
  initializeVideoController() async {
    _controller =
        (await getURLVideoCache(id: widget.newsId, url: widget.videoPath))!;
    _controller?.initialize().then((value) {
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _controller!,
          autoPlay: true,
          looping: true,
          aspectRatio: widget.news.media![widget.index]['aspectRatio'],
          allowFullScreen: true,
          showControlsOnInitialize: true,

          // Show controls on initialize
        );

        isControllerInitialized = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initializeVideoController();
  }

  @override
  Widget build(BuildContext context) {
    if (isControllerInitialized)
      return Stack(children: [
        Container(
          color: Colors.black,
          child: _controller != null
              ? _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Chewie(
                        controller: _chewieController!,
                      ),
                    )
                  : CircularProgressIndicator()
              : CircularProgressIndicator(),
        ),
        Positioned(
          top: -10,
          left: -5,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close_rounded),
            color: Colors.white,
          ),
        )
      ]);
    else
      return Center(
        child: Container(
            height: 30, width: 30, child: CircularProgressIndicator()),
      );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController?.dispose();
  }
}
