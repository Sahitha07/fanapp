import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'events_detail_page.dart';
import 'full_screen_image_view.dart';
import 'news_detail_page.dart';
import 'dart:math';



void main() {
  runApp(MyApp());
}
class User {
  final String name;
  final String profilePictureUrl;

  User({required this.name, required this.profilePictureUrl});
}


class MyApp extends StatelessWidget {
  final User user = User(
    name: 'User Name', // Replace with the user's name
    profilePictureUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9PTw6h8jdBjC4W70STTdcmKerQvrhmyUhlA&usqp=CAU', // Replace with the user's profile picture URL
  );
  final double drawerWidth = 100.0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('FAN'),
            backgroundColor: Colors.black,
            // Set app bar color to #2c142e
            bottom: TabBar(
              tabs: [
                Tab(text: 'News'),
                Tab(text: 'Events'),
                Tab(text: 'Gallery'),
              ],
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
          drawer: Drawer(
            child: Container(
              color: Colors.black,// Change the color here
              child: ListView(
                children: [
                  // Custom drawer header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(user.profilePictureUrl),
                          radius: 50.0,
                        ),
                        Text(
                          user.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w100, // Apply "thin" font weight
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Menu items
                  ListTile(
                    leading: Icon(Icons.account_circle,color: Colors.white),
                    title: Text('Account Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      // Add your functionality for account settings here
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.admin_panel_settings, color: Colors.white),
                    title: Text('Admin Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      // Add your functionality for admin settings here
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.white),
                    title: Text('Log Out',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      // Add your functionality for logging out here
                    },
                  ),
                ],
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black, Color(0xFFa447a2)], // Background gradient
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
    "RM's celebrates his 29th birthday by writing a letter to ARMY", "V releases his solo debut album 'Layover'", "Suchwita with V"
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
    'assets/bts1.jpeg', 'assets/bts2.jpeg', 'assets/bts3.jpeg', 'assets/bts4.png', 'assets/bts5.jpeg', 'assets/bts6.jpeg',];

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
