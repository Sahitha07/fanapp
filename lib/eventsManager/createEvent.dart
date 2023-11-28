import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan_project/models/event.dart';
import 'package:fan_project/providers/newsProvider.dart';
import 'package:fan_project/providers/userProvider.dart';
import 'package:fan_project/screens/mediaUploadScreen.dart';
import 'package:fan_project/utilityFunctions/generateRandom.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/material.dart';

import '../db_operations/firebase_db.dart';
import '../models/news.dart';
import '../newsManager/createNews.dart';

class EventCreationManager {
  static List<Uint8List> imagesList = [];
  static List<Uint8List> videosList = [];
}

Future<bool> createEvent(
    {required Events event, required UserProvider userProvider}) async {
  List<Map<String, dynamic>> mediaList = [];
  try {
    Map<String, dynamic> eventMap = event.toMap();
    List<String> imageURLsList = await uploadImagesToFirebaseStorage(
        EventCreationManager.imagesList,
        userProvider.loggedInUser!.username!,
        event.eventId!);
    List<String> videoURLsList = await uploadVideosToFirebaseStorage(
        EventCreationManager.videosList,
        userProvider.loggedInUser!.username!,
        event.eventId!);
    imageURLsList.forEach((element) {
      mediaList.add({'url': element, 'mediaType': 'image'});
    });
    videoURLsList.forEach((element) {
      mediaList.add({'url': element, 'mediaType': 'video'});
    });
    eventMap['createdAt'] = DateTime.now();
    eventMap['media'] = mediaList;

    await db
        .collection('users')
        .doc(userProvider.loggedInUser?.userId)
        .collection('events')
        .doc(event.eventId ?? generateRandomEventId())
        .set(eventMap);

    print("Event creation successful");
    return true;
  } catch (e) {
    return false;
  }
}
