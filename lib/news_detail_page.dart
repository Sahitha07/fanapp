import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventsPage extends StatelessWidget {
  final List<String> events = List.generate(10, (index) => 'Event ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xFF2C142E)],
          ),
        ),
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (BuildContext context, int index) {
            final eventName = events[index];
            return ListTile(
              title: Text(eventName, style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailsPage(eventName: eventName),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class EventDetailsPage extends StatelessWidget {
  final String eventName;

  EventDetailsPage({required this.eventName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eventName),
        backgroundColor: Color(0xFF2C142E),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xFF2C142E)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' $eventName',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'More detailed information about the event goes here.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  const url = 'https://www.youtube.com/playlist?list=PL5hrGMysD_GvC9VL7eeXG4j0apdqvh4lA'; // Replace with your event link
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Text('Visit Event Link', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


