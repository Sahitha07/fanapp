import 'package:flutter/material.dart';

class CustomUser {
  String? userId;
  String username;
  String email;
  String? profilePic;
  int totalNews = 0;
  CustomUser(
      { this.userId,
      required this.username,
      required this.email,
      this.profilePic,
      this.totalNews = 0});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'totalNews': totalNews,
      'profilePic': profilePic,
    };
  }

  factory CustomUser.fromMap(Map<String, dynamic> map) {
    return CustomUser(
        userId: map['userId']??'',
        username: map['username'],
        email: map['email'],
        totalNews: map['totalNews'],
        profilePic: map['profilePic'] ?? '');
    // ..createdIssues = List<String>.from(map['createdIssues'] ?? [])
  }
}
