import 'package:fan_project/screens/utilityWidgets/newsTileMediaDisplay.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fan_project/models/event.dart';
import 'package:intl/intl.dart';
import '../../providers/userProvider.dart';
import '../../models/news.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../mediaStorage/videoCache.dart';
import '../mediaStorage/imageCache.dart';

class EventDetailScreen extends StatefulWidget {
  Events event;
  EventDetailScreen({required this.event});

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

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
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.event.title,
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 20),
            if (!(widget.event.media == null || widget.event.media!.isEmpty))
              SizedBox(
                height: 250,
                width: 400,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.event.media!.length,
                    itemBuilder: (BuildContext context, int mediaIndex) {
                      if (widget.event.media![mediaIndex]['mediaType'] ==
                          'video') {
                        return FutureBuilder<VideoPlayerController?>(
                            future: getURLVideoCache(
                              id: widget.event.eventId!,
                              url: widget.event.media![mediaIndex]['url'],
                            ),
                            builder: (BuildContext context,
                                AsyncSnapshot<VideoPlayerController?>
                                    snapshot) {
                              if (snapshot.data != null) {
                                return MediaDisplayWidget(
                                  mediaList: widget.event.media,
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
                      } else if (widget.event.media![mediaIndex]['mediaType'] ==
                          'image') {
                        {
                          return FutureBuilder<String>(
                            future: getURLImageCache(
                                widget.event.media![mediaIndex]['url'],
                                widget.event.eventId!,
                                mediaIndex),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.data != null) {
                                return MediaDisplayWidget(
                                  mediaList: widget.event.media,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.white,
                ),
                SizedBox(width: 30),
                Text(
                  "${DateFormat('yyyy/MM/dd').format(widget.event.date)} - ${DateFormat('h:m').format(widget.event.date)}",
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                ),
                SizedBox(width: 30),
                Text(
                  "${widget.event.location}",
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
          ],
        ),
      ),
    );
  }
}
