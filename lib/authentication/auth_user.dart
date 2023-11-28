import 'package:fan_project/providers/eventsProvider.dart';
import 'package:fan_project/providers/newsProvider.dart';
import 'package:fan_project/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/homeScreen.dart';

User? authUser = FirebaseAuth.instance.currentUser;
FirebaseAuth? authInstance = FirebaseAuth.instance;
bool isLoggedIn() {
  if (authUser != null) {
    print("Already logged in with email ${authUser?.email}");
    return true;
  } else
    return false;
}

sendNewUserContextToHomeScreen(
    UserProvider userProvider,
    NewsProvider newsProvider,
    EventsProvider eventsProvider,
    String email) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    userProvider.allUsers.forEach((element) {
      print(element.email);
    });
    await userProvider.setLoggedInUser(email);
    await newsProvider.setUserProvider(userProvider: userProvider);
    await eventsProvider.setUserProvider(userProvider: userProvider);
    print(
        "USER PROVIDER ${userProvider.loggedInUser} NEWS PROVIDER ${newsProvider}");
    // newsProvider.getAllNewsStream();
  }
}
