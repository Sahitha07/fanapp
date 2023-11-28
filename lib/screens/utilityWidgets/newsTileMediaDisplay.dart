import 'package:chewie/chewie.dart';
import 'package:fan_project/screens/utilityWidgets/newsTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../mediaStorage/imageCache.dart';
import '../../models/news.dart';
import '../../providers/newsProvider.dart';
import '../../themes/defaultValues.dart';
import '../imageViewScreen.dart';
import '../tempNewsDetail.dart';
import 'dart:io';

class MediaDisplayWidget extends StatefulWidget {
  MediaDisplayWidget(
      {super.key,
      this.mediaList,
      this.videoController,
      required this.mediaType,
      this.imageUrl,
      this.index = 0});
  final List<Map<String, dynamic>>? mediaList;

  @override
  Key? get key => UniqueKey();

  VideoPlayerController? videoController;
  int index;
  String? imageUrl;
  final MediaType mediaType;
  @override
  State<MediaDisplayWidget> createState() => _MediaDisplayWidgetState();
}

class _MediaDisplayWidgetState extends State<MediaDisplayWidget> {
  ChewieController? _chewieController;
  bool isChewieControllerInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  void _initializeChewieController() {
    if (!isChewieControllerInitialized) {
      widget.videoController!.initialize().then((_) {
        if (mounted) {
          isChewieControllerInitialized = true;
          print("INITIALIZING CHEWIE CONTROLLER");
          setState(() {
            _chewieController = ChewieController(
                videoPlayerController: widget.videoController!,
                autoPlay: false,
                looping: true,
                aspectRatio: widget.mediaList![widget.index]['aspectRatio'],
                allowFullScreen: true,
                deviceOrientationsOnEnterFullScreen: DeviceOrientation.values,
                deviceOrientationsAfterFullScreen: DeviceOrientation.values);
          });
        }
      });
    }
  }

  Widget _buildImage() {
    File imageFile = File(widget.imageUrl!);

    if (imageFile.existsSync()) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.file(
          imageFile,
          height: 250,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Center(
          child: Text(
            'Error loading image',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    widget.videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ChewieController when needed
    if (widget.mediaType == MediaType.video) _initializeChewieController();

    return Column(
      children: [
        if (widget.mediaType == MediaType.video)
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              height: 250,
              decoration: BoxDecoration(color: Colors.black),
              child: _chewieController != null
                  ? Chewie(
                      controller: _chewieController!,
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width -
                          mainScreenPaddingHorizontal * 2,
                      height: 30,
                      color: Colors.black,
                      child: Center(child: CircularProgressIndicator())),
            ),
          )
        else if (widget.mediaType == MediaType.image)
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  File(widget.imageUrl!),
                  height: 250,
                  width: MediaQuery.of(context).size.width -
                      mainScreenPaddingHorizontal * 2,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.fullscreen),
                    color: Colors.white,
                    onPressed: () {
                      _showImagePopup(context, widget.imageUrl!);
                    },
                  ))
            ],
          ),
      ],
    );
  }
}

void _showImagePopup(BuildContext context, String imageUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ImageViewPopup(imageUrl: imageUrl);
    },
  );
}
