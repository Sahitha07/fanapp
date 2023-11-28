import 'dart:io';
import 'dart:typed_data';

import 'package:fan_project/screens/eventDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fan_project/models/event.dart';

import 'package:fan_project/mediaStorage/imageCache.dart';
import 'package:fan_project/mediaStorage/videoCache.dart';

class EventTile extends StatelessWidget {
  EventTile({super.key, required this.event});
  Events event;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text(
                event.title,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                DateFormat('yyyy/MM/dd').format(event.date),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          if (event.media != null && event.media!.isNotEmpty)
            EventTileMedia(
              event: event,
            )
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventDetailScreen(event: event)));
      },
    );
  }
}

class EventTileMedia extends StatelessWidget {
  EventTileMedia({super.key, required this.event});
  final Events event;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          if (event.media![0]['mediaType'] == 'image')
            FutureBuilder<String>(
              future:
                  getURLImageCache(event.media![0]['url'], event.eventId!, 0),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.data != null)
                  return Image.file(
                    File(snapshot.data!),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  );
                else
                  return Container(
                    height: 100,
                    width: 100,
                    color: Colors.transparent,
                    child: Center(
                      child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator()),
                    ),
                  );
              },
            )
          else
            FutureBuilder<Uint8List?>(
              future: generateVideoThumbnail(getURLVideoCache(
                  id: event.eventId!, url: event.media![0]['url'])),
              builder:
                  (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
                if (snapshot.data != null)
                  return Image.memory(
                    snapshot.data!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  );
                else
                  return Container(
                    height: 100,
                    width: 100,
                    color: Colors.transparent,
                    child: Center(
                      child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator()),
                    ),
                  );
              },
            ),
          Positioned(
            child: Text(
              event.media!.length.toString(),
              style: TextStyle(color: Colors.green),
            ),
            bottom: 0,
            right: 0,
          )
        ],
      ),
    );
  }
}
