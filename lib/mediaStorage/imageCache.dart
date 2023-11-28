import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImageCacheManager {
  static Map<String, dynamic> cachedImages = {};
  static Map<String, Completer<String>> imageDownloadCompleters = {};
}

int apiImageRequestCount = 0;

Future<String> getURLImageCache(String imageUrl, String id, int index) async {
  final cacheKey = '${id}_$index';

  if (ImageCacheManager.cachedImages.containsKey(cacheKey)) {
    return ImageCacheManager.cachedImages[cacheKey]['image_cache_path']!;
  } else if (ImageCacheManager.imageDownloadCompleters.containsKey(cacheKey)) {
    // If an image download is already in progress, wait for it to complete.
    return ImageCacheManager.imageDownloadCompleters[cacheKey]!.future;
  } else {
    return await _downloadAndCacheImage(imageUrl, cacheKey);
  }
}

Future<String> _downloadAndCacheImage(String imageUrl, String cacheKey) async {
  final dio = Dio();
  apiImageRequestCount++;
  print("IMAGE API REQUESTS $apiImageRequestCount");

  // Create a Completer to track the download process
  Completer<String> completer = Completer();

  // Store the Completer in the manager to prevent concurrent downloads
  ImageCacheManager.imageDownloadCompleters[cacheKey] = completer;

  final response = await dio.get(
    imageUrl,
    options: Options(responseType: ResponseType.bytes),
  );

  if (response.statusCode == 200) {
    final bytes = response.data as List<int>;

    final dir = await getTemporaryDirectory();
    final localImagePath = '${dir.path}/$cacheKey.png';

    final File imageFile = File(localImagePath);
    File createdFile = await imageFile.writeAsBytes(bytes);

    ImageCacheManager.cachedImages[cacheKey] = {
      'image_cache_path': localImagePath
    };

    // Remove the Completer from the manager after download completes
    ImageCacheManager.imageDownloadCompleters.remove(cacheKey);

    // Resolve the Completer with the local image path
    completer.complete(localImagePath);

    return completer.future;
  } else {
    // Remove the Completer if the download fails
    ImageCacheManager.imageDownloadCompleters.remove(cacheKey);

    completer.completeError(Exception('Failed to download and cache image'));
    return completer.future;
  }
}

void clearAllImageCache() {
  ImageCacheManager.cachedImages.clear();
}

Future<Uint8List?> generateVideoThumbnail(
    Future<VideoPlayerController?> videoPlayerController) async {
  String? videoUrl;

  var tempp = await videoPlayerController;
  videoUrl = tempp?.dataSource;

  final thumbnail = await VideoThumbnail.thumbnailData(
    video: videoUrl != null ? videoUrl : '',
    imageFormat: ImageFormat.JPEG,
    quality: 100,
  );
  return thumbnail;
}

void main() async {
  try {
    final imageUrl =
        'https://i.pinimg.com/originals/a7/61/bf/a761bfedc80bba1e959f6a96a8341bc6.jpg';
    final localImagePath =
        await getURLImageCache(imageUrl, 'example_news_id', 1);

    print('Local image path: $localImagePath');

    // Use localImagePath to display the cached image in your app.

    // Clear all cached images if needed:
    // clearAllImageCache();
  } catch (e) {
    print('Error: $e');
  }
}
