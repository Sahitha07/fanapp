import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'events_detail_page.dart';
import 'full_screen_image_view.dart';
import 'news_detail_page.dart';
import 'dart:math';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('FAN'),
            backgroundColor: Color(0xFF2C142E), // Set app bar color to #2c142e
            bottom: TabBar(
              tabs: [
                Tab(text: 'News'),
                Tab(text: 'Events'),
                Tab(text: 'Gallery'),
              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black, Color(0xFF2C142E)], // Background gradient
              ),
            ),
            child: TabBarView(
              children: [
                NewsTab(),
                EventsTab(),
                GalleryTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class NewsTab extends StatelessWidget {
  String _generateRandomDate() {
    final random = Random();
    final day = random.nextInt(30) + 1; // Generate a random day between 1 and 30
    final month = random.nextInt(12) + 1; // Generate a random month between 1 and 12

    return '$month/$day/2023'; // Assuming the year is 2023
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          19,
              (index) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      _generateRandomDate(), // Display a random date
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 16), // Add spacing between date and article title
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 1,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  'BTS News Article $index',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'Details about the news article $index',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Navigate to the NewsDetailPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailPage(
                        title: 'BTS News Article $index',
                        content: 'Details about the news article $index',
                        link: 'https://example.com/article',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}// Provide the actual link here

class EventsTab extends StatelessWidget {
  final List<String> eventNames = [
    "RM's celebrates his 29th birthday by writing a letter to ARMY",
    "V releases his solo debut album 'Layover'",
    "Suchwita with V"
    // Add more events if needed
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          eventNames.length,
              (index) => Column(
            children: [
              ListTile(
                title: Text(
                  eventNames[index],
                  style: TextStyle(color: Colors.white),
                ),

                onTap: () {
                  // Navigate to the EventDetailsPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailsPage(
                        eventName: eventNames[index],
                      ),
                    ),
                  );
                },
              ),
              Divider(
                color: Colors.white,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class GalleryTab extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/bts1.jpeg',
    'assets/bts2.jpeg',
    'assets/bts3.jpeg',
    'assets/bts4.png',
    'assets/bts5.jpeg',
    'assets/bts6.jpeg',];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        final imagePath = imagePaths[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullScreenImageView(imagePath: imagePath),
              ),
            );// Add functionality to view the image in full screen
          },
          child: Card(
            color: Color.fromRGBO(255, 255, 255, 0.3),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

