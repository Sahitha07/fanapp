import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan_project/providers/newsProvider.dart';
import 'package:fan_project/providers/userProvider.dart';
import 'package:fan_project/screens/mediaUploadScreen.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/material.dart';

import '../db_operations/firebase_db.dart';
import '../models/news.dart';

class NewsCreationManager {
  static List<Uint8List> imagesList = [];
  static List<Uint8List> videosList = [];
}

Future<bool> createNews(
    {required News news,
    required NewsProvider newsProvider,
    required UserProvider userProvider}) async {
  List<Map<String, dynamic>> mediaList = [];
  try {
    int totalNews = newsProvider.totalNews;

    Map<String, dynamic> newsMap = news.toMap();

    List<String> imageURLsList = await uploadImagesToFirebaseStorage(
        NewsCreationManager.imagesList,
        userProvider.loggedInUser!.username!,
        news.newsId!);
    List<String> videoURLsList = await uploadVideosToFirebaseStorage(
        NewsCreationManager.videosList,
        userProvider.loggedInUser!.username!,
        news.newsId!);
    imageURLsList.forEach((element) {
      mediaList.add({'url': element, 'mediaType': 'image'});
    });
    videoURLsList.forEach((element) {
      mediaList.add({'url': element, 'mediaType': 'video'});
    });
    newsMap['createdAt'] = DateTime.now();
    newsMap['media'] = mediaList;
    await db
        .collection('users')
        .doc(userProvider.loggedInUser?.userId)
        .collection('news')
        .doc(news.newsId)
        .set(newsMap);
    NewsCreationManager.imagesList.clear();
    mediaList.clear();
    // await newsProvider.incrementTotalNews();

    print("News creation successful");
    return true;
  } catch (e) {
    return false;
  }
}

Future<List<String>> uploadImagesToFirebaseStorage(
    List<Uint8List> images, String username, String newsId) async {
  List<String> imageUrls = [];
  for (int i = 0; i < images.length; i++) {
    String imageName = '{}image-$i.jpg';
    storage.Reference storageReference = storage.FirebaseStorage.instance
        .ref('${username}/${newsId}/img/$imageName');

    storage.UploadTask uploadTask = storageReference.putData(images[i]);

    await uploadTask.whenComplete(() async {
      String imageUrl = await storageReference.getDownloadURL();
      imageUrls.add(imageUrl);
    });
  }
  return imageUrls;
}

Future<List<String>> uploadVideosToFirebaseStorage(
    List<Uint8List> images, String username, String newsId) async {
  List<String> videoUrls = [];
  for (int i = 0; i < images.length; i++) {
    String videoName = 'video-$i.jpg';
    storage.Reference storageReference = storage.FirebaseStorage.instance
        .ref('${username}/${newsId}/video/$videoName');

    storage.UploadTask uploadTask = storageReference.putData(images[i]);

    await uploadTask.whenComplete(() async {
      String imageUrl = await storageReference.getDownloadURL();
      videoUrls.add(imageUrl);
    });
  }
  return videoUrls;
}
