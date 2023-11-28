import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan_project/mediaStorage/imageCache.dart';
import 'package:fan_project/screens/newsDetailScreen.dart';
import 'package:fan_project/screens/tempNewsDetail.dart';
import 'package:fan_project/utilityFunctions/dateConversion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../mediaStorage/videoCache.dart';
import '../../providers/newsProvider.dart';
import '../../providers/userProvider.dart';
import 'package:fan_project/models/news.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../themes/defaultValues.dart';
import 'newsTile.dart';
import 'newsTileMediaDisplay.dart';

class NewsTab extends StatefulWidget {
  UserProvider userProvider;
  NewsProvider newsProvider;

  VideoPlayerController? videoController =
      VideoPlayerController.networkUrl(Uri.parse(defVidLink));
  NewsTab({required this.userProvider, required this.newsProvider});
  @override
  _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
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
              autoPlay: true,
              looping: true,
              // aspectRatio: widget.news.media![0]['aspectRatio'],
              aspectRatio: 16 / 9,
              allowFullScreen: false,
            );
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _initializeChewieController();
    List<News> allNews = widget.newsProvider.allNews;
    return StreamBuilder<QuerySnapshot>(
      stream: widget.newsProvider.newsStream,
      builder: (context, snapshot) {
        return Stack(
          children: [
            Container(
              color: Colors.black, // Your desired background color
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              color: Colors.black.withOpacity(0.8),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: mainScreenPaddingHorizontal),
                child: ListView.builder(
                  key: UniqueKey(),
                  itemCount: widget.newsProvider.allNews.length,
                  itemBuilder: (context, index) {
                    // print("NEWS MEDIAAAA: ${allNews[index].media}");
                    News newsItem = allNews[index];
                    return Container(
                      // color: Colors.red,
                      child: Column(
                        children: [
                          GestureDetector(
                            child: NewsTile(
                              news: newsItem,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsDetailScreen(
                                            title: newsItem.title,
                                            news: newsItem,
                                          )));
                            },
                          ),
                          if (newsItem.media != null &&
                              newsItem.media!.isNotEmpty)
                            Container(
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                children: [
                                  ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: newsItem.media!.length,
                                      itemBuilder: (BuildContext context,
                                          int mediaIndex) {
                                        if (newsItem.media![mediaIndex]
                                                ['mediaType'] ==
                                            'video') {
                                          return FutureBuilder<
                                                  VideoPlayerController?>(
                                              future: getURLVideoCache(
                                                id: newsItem.newsId!,
                                                url: newsItem.media![mediaIndex]
                                                    ['url'],
                                              ),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<
                                                          VideoPlayerController?>
                                                      snapshot) {
                                                if (snapshot.data != null) {
                                                  print(snapshot.data);
                                                  return MediaDisplayWidget(
                                                    mediaList:
                                                        allNews[index].media,
                                                    videoController:
                                                        snapshot.data!,
                                                    mediaType: MediaType.video,
                                                    index: mediaIndex,
                                                  );
                                                } else
                                                  return Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 30,
                                                      color: Colors.black,
                                                      child: Center(
                                                          child:
                                                              CircularProgressIndicator()));
                                              });
                                        } else if (newsItem.media![mediaIndex]
                                                ['mediaType'] ==
                                            'image') {
                                          {
                                            return FutureBuilder<String>(
                                              future: getURLImageCache(
                                                  allNews[index]
                                                          .media![mediaIndex]
                                                      ['url'],
                                                  allNews[index].newsId!,
                                                  mediaIndex),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<String>
                                                      snapshot) {
                                                if (snapshot.data != null) {
                                                  return MediaDisplayWidget(
                                                    mediaList:
                                                        allNews[index].media,
                                                    mediaType: MediaType.image,
                                                    imageUrl: snapshot.data!,
                                                    index: mediaIndex,
                                                  );
                                                } else {
                                                  return Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 30,
                                                      color: Colors.black,
                                                      child: Center(
                                                          child:
                                                              CircularProgressIndicator()));
                                                }
                                              },
                                            );
                                          }
                                        }
                                      }),
                                  if (newsItem.media!.length > 1)
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        child: Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          color:
                                              Color.fromARGB(20, 255, 255, 255),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                  top: 12,
                                                  left: 9,
                                                  child: Text(
                                                    "+ ${newsItem.media!.length - 1}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          SizedBox(height: 10),
                          Divider(
                            color: Colors.white,
                            thickness: 0.7,
                            height: 0,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
