import 'package:chewie/chewie.dart';
import 'package:fan_project/mediaStorage/videoCache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:typed_data';
import 'package:fan_project/models/news.dart';
import 'dart:io';
import '../../mediaStorage/imageCache.dart';
import 'videoPlayerWidget.dart';

class GalleryVideoCard extends StatelessWidget {
  GalleryVideoCard({
    Key? key,
    required this.news,
    this.index = 0,
  }) : super(key: key);

  final News news;

  final int index;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: generateVideoThumbnail(
          getURLVideoCache(id: news.newsId!, url: news.media![index]['url'])),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final thumbnail = snapshot.data;
          return thumbnail != null
              ? Stack(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: Image.memory(thumbnail, fit: BoxFit.cover))
                      ]),
                  Positioned(
                      child: Center(
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(100, 0, 0, 0),
                      maxRadius: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5, right: 5),
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 40,
                            ),
                            onPressed: () {
                              _showVideoPopup(
                                  context: context,
                                  videoPath: news.media![index]['url'],
                                  newsId: news.newsId!);
                            },
                          ),
                        ),
                      ),
                    ),
                  ))
                ])
              : CircularProgressIndicator();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  void _showVideoPopup(
      {required BuildContext context,
      required String videoPath,
      required String newsId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: VideoPlayerWidget(
            videoPath: videoPath,
            newsId: newsId,
            news: news,
            index: index,
          ),
        );
      },
    );
  }
}
