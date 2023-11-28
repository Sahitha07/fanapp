import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan_project/facebookModule/fetchFacebookData.dart';
import 'package:fan_project/providers/userProvider.dart';
import 'package:fan_project/utilityFunctions/dateConversion.dart';
import 'package:fan_project/utilityFunctions/generateRandom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fan_project/db_operations/firebase_db.dart';

import '../models/news.dart';
import 'package:intl/intl.dart';

import '../themes/defaultValues.dart';

enum NewsFetchStatus { idle, initiated, fetched }

class NewsProvider with ChangeNotifier {
  List<News> allNews = [];
  List<int> newsWithMediaIndices = [];
  bool isNewsStreamFetched = false;

  NewsFetchStatus newsFetchStatus = NewsFetchStatus.idle;
  Stream<QuerySnapshot>? newsStream;
  int totalNews = 0;
  UserProvider userProvider;
  NewsProvider({required this.userProvider}) {
    if (newsFetchStatus != NewsFetchStatus.initiated) getAllNewsStream();
  }

  @override
  notifyListeners() {
    if (kDebugMode) {
      print("Notifying listeners");
    }
    super.notifyListeners();
  }

  getAllNewsStream({bool isNotifyListener = true}) async {
    if (userProvider.loggedInUser == null) {
      print("User is null");
      return;
    }

    isNewsStreamFetched = true;
    newsFetchStatus = NewsFetchStatus.initiated;
    print("FETCHING NEWS STREAMMMM");
    totalNews = userProvider.loggedInUser!.totalNews!;
    newsStream = db
        .collection('users')
        .doc(userProvider.loggedInUser?.userId)
        .collection('news')
        .orderBy('createdAt', descending: true)
        .snapshots();
    newsStream!.listen((snapshot) async {
      final List<News> newsList = [];
      newsWithMediaIndices.clear();
      snapshot.docs.forEach((element) {
        News newsItem = News.fromMap(element.data() as Map<String, dynamic>);

        if (newsItem.media != null && newsItem.media!.isNotEmpty) {
          newsWithMediaIndices.add(newsList.length);
        }
        newsList.add(newsItem);
      });
      allNews.clear();
      allNews.addAll(newsList);

      await getFacebookPosts(isNotifyListener: isNotifyListener);
      if (isNotifyListener) notifyListeners();

      newsFetchStatus = NewsFetchStatus.initiated;
    });
  }

  getFacebookPosts({bool isNotifyListener = true}) async {
    print("Calling facebook posts get method");
    List fbPosts = [];
    fbPosts = await fetchFacebookPosts();
    fbPosts.forEach((post) async {
      if (post['message'] != null || post['attachments'] != null) {
        DateTime postCreatedAt = stringToDate(post['created_time']);
        String newsId = post['id'];

        List<Map<String, dynamic>> media = await getValidMedia(post, newsId);

        News newsItem = News(
            newsId: newsId,
            title: "Facebook Post",
            description: post['message'] ?? "",
            createdAt: postCreatedAt,
            media: media,
            newsCreatedPlatform: NewsCreatedPlatform.Meta);

        if (newsItem.media != null && newsItem.media!.isNotEmpty) {
          newsWithMediaIndices.add(allNews.length);
        }
        allNews.add(newsItem);
      }
      if (isNotifyListener) notifyListeners();
    });
  }

  incrementTotalNews() async {
    totalNews += 1;
    await db
        .collection('user')
        .doc(userProvider.loggedInUser?.username)
        .update({'totalNews': totalNews});
    userProvider.loggedInUser?.totalNews += 1;
    notifyListeners();
  }

  setUserProvider(
      {required UserProvider userProvider,
      bool isNotifyListener = true}) async {
    this.userProvider = userProvider;
    if (isNotifyListener) notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getValidMedia(
      var post, String newsId) async {
    List<Map<String, dynamic>> urls = [];

    if (post['attachments'] != null) {
      var attachments = post['attachments'];
      var attachmentData = attachments['data'] ?? [];

      if (attachmentData.isNotEmpty) {
        for (var element in attachmentData) {
          if (element['subattachments'] == null) {
            urls.addAll(addMedia(element));
          } else if (element['subattachments'] != null) {
            element['subattachments']['data'].forEach((subattachment) {
              urls.addAll(addMedia(subattachment));
            });
          }
        }
      }
    }
    print("URLS_NO: ${urls.length} , MY URLSSS: ${urls} ");
    return urls;
  }

  List<Map<String, dynamic>> addMedia(var element) {
    List<Map<String, dynamic>> urls = [];
    String type = element['type'];

    if (type.contains('video') || type.contains('animated_image')) {
      type = 'video';
    } else if (type.contains('photo')) {
      type = 'image';
    }

    var media = element['media'];
    var aspectRatio = media != null
        ? (media['image']['width'] - mainScreenPaddingHorizontal * 2) /
            (media['image']['height'])
        : 16 / 9;

    if (type == 'video') {
      var source = media ?? [];
      var sourceUrl = source.isNotEmpty ? source['source'] : '';

      if (sourceUrl != null) {
        urls.add({
          'mediaType': type,
          'url': sourceUrl,
          'aspectRatio': aspectRatio,
          // 'cachePath': cachePath
        });
      }
    } else if (type == 'image') {
      var sourceImg = media != null ? media['image'] : [];
      var sourceUrl = sourceImg.isNotEmpty ? sourceImg['src'] : '';

      if (sourceUrl != null) {
        urls.add({
          'mediaType': type,
          'url': sourceUrl,
          'aspectRatio': aspectRatio,
          // 'cachePath': cachePath
        });
      }
    }
    return urls;
  }
}
