import 'dart:typed_data';
import 'dart:io';

import 'package:fan_project/newsManager/createNews.dart';
import 'package:fan_project/providers/userProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

typedef MediaCallback = void Function(
    List<Uint8List> ImageBytesList, List<Uint8List> VideosBytesList);

class ImageUploaderWidget extends StatefulWidget {
  ImageUploaderWidget({super.key, required this.onMediaUploaded});

  final MediaCallback onMediaUploaded;
  @override
  _ImageUploaderWidgetState createState() => _ImageUploaderWidgetState();
}

class _ImageUploaderWidgetState extends State<ImageUploaderWidget> {
  final ImagePicker _picker = ImagePicker();
  List<Uint8List> imageBytesList = [];
  List<Uint8List> videoBytesList = [];

  Future<void> pickMedia() async {
    final pickedFile = await _picker.pickMedia();

    if (pickedFile != null) {
      if (pickedFile.path.endsWith('.mp4') ||
          pickedFile.path.endsWith('.mov')) {
        // It's a video
        Uint8List mediaBytes = await File(pickedFile.path).readAsBytes();
        setState(() {
          videoBytesList.add(mediaBytes);
        });
      } else {
        // It's an image
        Uint8List mediaBytes = await File(pickedFile.path).readAsBytes();
        setState(() {
          imageBytesList.add(mediaBytes);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Upload'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: pickMedia,
            child: const Text('Pick and Upload Media'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: imageBytesList.length + videoBytesList.length,
              itemBuilder: (context, index) {
                if (index < imageBytesList.length) {
                  // Display images
                  return Image.memory(imageBytesList[index]);
                } else {
                  // Display videos
                  final videoIndex = index - imageBytesList.length;
                  return Text("Uploaded video");
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // if (imageBytesList.isNotEmpty) {
              //   imageBytesList.forEach((element) {
              //     // Handle image upload
              //     NewsCreationManager.imagesList.add(element);
              //   });
              // }
              //
              // if (videoBytesList.isNotEmpty) {
              //   videoBytesList.forEach((element) {
              //     // Handle video upload
              //     NewsCreationManager.videosList.add(element);
              //   });
              //
              // }
              widget.onMediaUploaded(imageBytesList, videoBytesList);
              setState(() {
                imageBytesList.clear();
                videoBytesList.clear();
              });

              Navigator.pop(context);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerWidget extends StatelessWidget {
  final Uint8List mediaBytes;

  VideoPlayerWidget({required this.mediaBytes});

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(Uri.parse("uri") as VideoPlayerController);
  }
}
