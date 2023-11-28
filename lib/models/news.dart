import 'package:flutter/material.dart';
import 'package:fan_project/utilityFunctions/dateConversion.dart';

enum NewsCreatedPlatform { native, Meta, X, Instagram }

class News {
  String? newsId;
  String title;
  String description;
  List<Map<String, dynamic>>? media;
  DateTime? createdAt;
  NewsCreatedPlatform newsCreatedPlatform;
  News(
      {this.newsId,
      required this.title,
      required this.description,
      this.media,
      this.createdAt,
      this.newsCreatedPlatform = NewsCreatedPlatform.native});

  Map<String, dynamic> toMap() {
    return {
      'newsId': newsId,
      'title': title,
      'description': description,
      'media': media,
      'createdAt': createdAt,
      'newsCreatedPlatform':
          newsCreatedPlatform.name ?? NewsCreatedPlatform.native.name
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
        newsId: map['newsId'],
        title: map['title'],
        description: map['description'],
        createdAt: formatDate(map['createdAt'].toDate()) ?? DateTime.now(),
        media: List<Map<String, dynamic>>.from(map['media'] ?? []),
        newsCreatedPlatform: map['newsCreationPlatform'] != null
            ? NewsCreatedPlatform.values.byName(map['newsCreationPlatform'])
            : NewsCreatedPlatform.native);

    // ..createdIssues = List<String>.from(map['createdIssues'] ?? [])
  }
}

enum MediaType { image, video }
