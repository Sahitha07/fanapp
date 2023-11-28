import 'dart:io';

import 'package:fan_project/screens/utilityWidgets/galleryImageCard.dart';
import 'package:fan_project/screens/utilityWidgets/galleryVideoCard.dart';
import 'package:fan_project/temp.dart';
import 'package:flutter/material.dart';
import 'package:fan_project/mediaStorage/videoCache.dart';
import 'package:fan_project/mediaStorage/imageCache.dart';
import 'package:fan_project/providers/newsProvider.dart';
import 'package:fan_project/providers/userProvider.dart';
import 'package:video_player/video_player.dart';
import 'package:fan_project/themes/defaultValues.dart';

class GalleryTab extends StatelessWidget {
  List<Map<String, dynamic>> imagePaths = [];
  List<Map<String, dynamic>> videoPaths = [];
  NewsProvider newsProvider;
  GalleryTab({super.key, required this.newsProvider});

  @override
  Widget build(BuildContext context) {
    print(CachedVideosManager.cachedVideos);
    List<Card> mediaCards = [];
    newsProvider.newsWithMediaIndices.forEach((newsIndex) {
      for (int i = 0; i < newsProvider.allNews[newsIndex].media!.length; i++) {
        if (newsProvider.allNews[newsIndex].media![i]['mediaType'] == 'image') {
          mediaCards.add(Card(
            key: UniqueKey(),
            shape: cardShapeBorder,
            elevation: 10,
            child: FutureBuilder<String>(
              future: getURLImageCache(
                  newsProvider.allNews[newsIndex].media![i]['url'],
                  newsProvider.allNews[newsIndex].newsId!,
                  i),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.data != null)
                  return GalleryImageCard(imagePath: snapshot.data!);
                else
                  return CircularProgressIndicator();
              },
            ),
          ));
        }
        if (newsProvider.allNews[newsIndex].media![i]['mediaType'] == 'video') {
          mediaCards.add(Card(
              key: UniqueKey(),
              elevation: 10,
              shape: cardShapeBorder,
              child: (FutureBuilder<VideoPlayerController?>(
                future: getURLVideoCache(
                    id: newsProvider.allNews[newsIndex].newsId!,
                    url: newsProvider.allNews[newsIndex].media![i]['url']),
                builder: (BuildContext context,
                    AsyncSnapshot<VideoPlayerController?> snapshot) {
                  if (snapshot.data != null)
                    // return GalleryVideoCard(
                    //   news: newsProvider.allNews[newsIndex],
                    //   videoController: snapshot.data,
                    //   index: i,
                    // );
                    return GalleryVideoCard(
                        news: newsProvider.allNews[newsIndex], index: i);
                  else
                    return CircularProgressIndicator();
                },
              ))));
        }
      }
    });
    return Container(
      color: Colors.black, // Set background color to black
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: mediaCards.length,
        itemBuilder: (context, index) {
          return mediaCards[index];
        },
      ),
    );
  }
}
