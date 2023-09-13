import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'full_screen_image_view.dart';
import 'news_detail_page.dart';


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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          10,
              (index) => Column(
            children: [
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
                        link: 'https://example.com/article', // Provide the actual link here
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
class EventsTab extends StatelessWidget {
  final List<String> youtubeLinks = [
    'https://www.youtube.com/user/ibighit',
    'https://www.youtube.com/user/BANGTANTV',
    // Add more YouTube links here
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: youtubeLinks.length,
      itemBuilder: (context, index) {
        final link = youtubeLinks[index];
        return Card(
          margin: EdgeInsets.all(8),
          color: Color.fromRGBO(255, 255, 255, 0.3),
          child: ListTile(
            title: Text(
              'BTS YouTube Channel $index',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              link,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () async {
              if (await canLaunch(link)) {
                await launch(link);
              } else {
                throw 'Could not launch $link';
              }
            },
          ),
        );
      },
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
            );


            // Add functionality to view the image in full screen
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




