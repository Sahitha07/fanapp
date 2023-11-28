import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:dio/dio.dart';

String defVidLink =
    "https://assets.contentstack.io/v3/assets/bltb6530b271fddd0b1/blt3d19d83ba51eb18f/5ecad7d297b46c1911ad1868/Brimstone_X_v001_web.mp4";

class CachedVideosManager {
  static Map<String, dynamic> cachedVideos = {};
  static Map<String, Completer<VideoPlayerController?>>
      videoDownloadCompleters = {};
}

Future<VideoPlayerController?> getURLVideoCache(
    {required String id, required String url, int index = 0}) async {
  if (url.isEmpty || url == null) {
    url = defVidLink;
  }
  final cacheKey = '${id}_$index';
  // Check if the video download is already in progress or completed
  if (CachedVideosManager.videoDownloadCompleters.containsKey(cacheKey)) {
    // Return the existing Completer's future
    return CachedVideosManager.videoDownloadCompleters[cacheKey]!.future;
  }

  Directory dir = await getTemporaryDirectory();
  String localVideoPath = '${dir.path}/video_$cacheKey.mp4';

  // Check if the video is already cached
  if (File(localVideoPath).existsSync()) {
    print("VIDEO ALREADY EXISTS!! Returning Cache path ${localVideoPath}");
    return VideoPlayerController.file(
      File(localVideoPath),
    );
  } else {
    print("NEED TO DOWNLOAD VIDEOOO ${localVideoPath}");
    return _downloadAndCacheVideo(url, localVideoPath, id);
  }
}

int apiRequestCount = 0;

Future<VideoPlayerController?> _downloadAndCacheVideo(
  String url,
  String filePath,
  String id,
) async {
  final dio = Dio();

  // Create a Completer to track the download process
  Completer<VideoPlayerController?> completer = Completer();

  // Store the Completer in the manager to prevent concurrent downloads
  CachedVideosManager.videoDownloadCompleters[id] = completer;

  // Increment the counter before making the API request
  apiRequestCount++;
  print("VIDEO API REQUESTS ${apiRequestCount}");
  final response = await dio.get(
    url,
    options: Options(responseType: ResponseType.stream),
  );

  if (response.statusCode == 200) {
    final file = File(filePath);
    final stream = response.data.stream;

    await file.create(recursive: true);
    final sink = file.openWrite();

    await stream.forEach((data) {
      sink.add(data);
    });

    await sink.close();

    // Remove the Completer from the manager after download completes
    CachedVideosManager.videoDownloadCompleters.remove(id);

    // Resolve the Completer with the VideoPlayerController
    completer.complete(VideoPlayerController.file(file));

    return completer.future;
  } else {
    print('Failed to load video');
    completer.complete(null);
    return completer.future;
  }
}

Future<void> clearAllVideoCache() async {
  try {
    final dir = await getTemporaryDirectory();
    if (dir.existsSync()) {
      await dir.delete(recursive: true);
      print('All video cache cleared');
    } else {
      print('Temporary directory does not exist');
    }
  } catch (e) {
    print('Error while clearing video cache: $e');
  }
}
