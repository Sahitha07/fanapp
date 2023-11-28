import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../models/news.dart';
import 'package:path_provider/path_provider.dart';

class TempNewsDetail extends StatefulWidget {
  TempNewsDetail({super.key, required this.news});
  News news;
  @override
  State<TempNewsDetail> createState() => _TempNewsDetailState();
}

class _TempNewsDetailState extends State<TempNewsDetail> {
  VideoPlayerController? _controller;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();

    if (widget.news.media != null && widget.news.media!.isNotEmpty) {
      // _controller = VideoPlayerController.networkUrl(
      //     Uri.parse(widget.news.media![0]['url']));

      _controller = VideoPlayerController.networkUrl(
          Uri.parse(widget.news.media![0]['cachePath']))
        ..initialize().then((value) {
          setState(() {
            // _chewieController?.pause();
          });
        });

      _chewieController = ChewieController(
        videoPlayerController: _controller!,
        autoPlay: true,
        looping: false,
        aspectRatio: widget.news.media![0]['aspectRatio'],
        allowFullScreen: false,
      );

      // _controller!.initialize().then((_) {
      //   setState(() {
      //     // _chewieController?.pause();
      //   });
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    getTemporaryDirectory().then((value) {
      print("TEMPPPPPPP DIRRRRECTORY: ${value}");
    });
    return MaterialApp(
      home: Chewie(
        controller: _chewieController!,
      ),
    );
  }
}
