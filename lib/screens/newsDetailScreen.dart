import 'package:fan_project/screens/utilityWidgets/newsTileMediaDisplay.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/newsProvider.dart';
import '../../providers/userProvider.dart';
import '../../models/news.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../mediaStorage/videoCache.dart';
import '../mediaStorage/imageCache.dart';

class NewsDetailScreen extends StatefulWidget {
  final String title;
  News news;
  NewsDetailScreen({required this.title, required this.news});

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  List<Map<String, String>> mediaList = [
    {
      'type': 'image',
      'url':
          'https://6.soompi.io/wp-content/uploads/image/20230924152226_Jungkook-8.jpg'
    },
    {'type': 'video', 'url': 'assets/Val_Skye_X_Ability_Web.mp4'},
    {
      'type': 'image',
      'url':
          'https://0.soompi.io/wp-content/uploads/2023/09/24082332/Jungkook-4-1.jpeg'
    },
    {'type': 'video', 'url': 'assets/Phoenix_Q_v001_web.mp4'},
    {
      'type': 'image',
      'url':
          'https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2023%2F09%2Fbts-jungkook-jack-harlow-3d-new-single-announcement-001.jpg?cbr=1&q=90'
    }
    // Add more media items as needed
  ];

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(
      'assets/Val_Skye_X_Ability_Web.mp4', // Change this to your local video path
    );
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
    );
    _videoPlayerController.initialize().then((_) {
      setState(() {}); // Ensure the video is initialized before displaying
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Widget buildMediaItem(Map<String, String> media) {
    if (media['type'] == 'video') {
      return Chewie(
        controller: ChewieController(
          videoPlayerController: VideoPlayerController.asset(media['url']!),
          aspectRatio: 16 / 9,
          autoPlay: true,
          looping: true,
        ),
      );
    } else if (media['type'] == 'image') {
      return Container(
        width: 500, // Set width as per your requirement
        height: 500, // Set height as per your requirement
        child: Image.network(
          media['url']!,
          fit: BoxFit.cover,
        ),
      );
    }
    return Container(); // Return an empty container for unknown media type
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/images/Fan_Logo.svg',
              width: 30,
              height: 30,
              color: Colors.white,
            ),
            SizedBox(width: 20),
            Text(
              'FAN',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0), // Add padding to the content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              widget.title,
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            if (!(widget.news.media == null || widget.news.media!.isEmpty))
              SizedBox(
                height: 250,
                width: 400,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.news.media!.length,
                    itemBuilder: (BuildContext context, int mediaIndex) {
                      if (widget.news.media![mediaIndex]['mediaType'] ==
                          'video') {
                        return FutureBuilder<VideoPlayerController?>(
                            future: getURLVideoCache(
                              id: widget.news.newsId!,
                              url: widget.news.media![mediaIndex]['url'],
                            ),
                            builder: (BuildContext context,
                                AsyncSnapshot<VideoPlayerController?>
                                    snapshot) {
                              if (snapshot.data != null) {
                                return MediaDisplayWidget(
                                  mediaList: widget.news.media,
                                  videoController: snapshot.data!,
                                  mediaType: MediaType.video,
                                  index: mediaIndex,
                                );
                              } else
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 30,
                                    color: Colors.black,
                                    child: Center(
                                        child: CircularProgressIndicator()));
                            });
                      } else if (widget.news.media![mediaIndex]['mediaType'] ==
                          'image') {
                        {
                          return FutureBuilder<String>(
                            future: getURLImageCache(
                                widget.news.media![mediaIndex]['url'],
                                widget.news.newsId!,
                                mediaIndex),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.data != null) {
                                return MediaDisplayWidget(
                                  mediaList: widget.news.media,
                                  mediaType: MediaType.image,
                                  imageUrl: snapshot.data!,
                                  index: mediaIndex,
                                );
                              } else {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 30,
                                    color: Colors.black,
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              }
                            },
                          );
                        }
                      }
                    }),
              ),
            SizedBox(height: 20),
            Text(
              '${widget.news.description}',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
