import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan_project/facebookModule/fetchFacebookData.dart';
import 'package:fan_project/models/news.dart';
import 'package:fan_project/providers/newsProvider.dart';
import 'package:fan_project/providers/userProvider.dart';
import 'package:fan_project/screens/createNewsScreen.dart';
import 'package:fan_project/sharedWidgets/appBar.dart';
import 'package:fan_project/sharedWidgets/bottomNavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fan_project/screens/utilityWidgets/newsTab.dart';
import 'package:fan_project/sharedWidgets/tempSidebar.dart';
import 'package:fan_project/authentication/auth_user.dart';
import 'dart:math';
import 'dart:io';
import 'package:fan_project/authentication/registration.dart';

import 'estoreHome.dart';
import 'utilityWidgets/galleryTab.dart';
import 'utilityWidgets/eventsTab.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    // userProvider.setLoggedInUser(FirebaseAuth.instance.currentUser!.email!);
    NewsProvider newsProvider = Provider.of<NewsProvider>(context);
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: NavAppBar(
                title: userProvider
                    .loggedInUser?.username), // Use NavAppBar as the app bar
            drawer: Sidebar(), // Add your Sidebar here
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black,
                    Color(0xFF2C142E),
                  ], // Background gradient
                ),
              ),
              child: TabBarView(
                children: [
                  NewsTab(
                    userProvider: userProvider,
                    newsProvider: newsProvider,
                  ),
                  // EventsTab(),
                  EventsTab(),
                  GalleryTab(
                    newsProvider: newsProvider,
                  ),
                  ProductListingPage(),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavBar(),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     newsProvider.getFacebookPosts();
            //   },
            // ),
          ),
        ),
      ),
    );
  }
}
