import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan_project/facebookModule/fetchFacebookData.dart';
import 'package:fan_project/providers/userProvider.dart';
import 'package:fan_project/utilityFunctions/dateConversion.dart';
import 'package:fan_project/utilityFunctions/generateRandom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fan_project/db_operations/firebase_db.dart';
import 'package:intl/intl.dart';
import '../themes/defaultValues.dart';
import 'package:fan_project/models/event.dart';

enum EventFetchStatus { idle, initiated, fetched }

class EventsProvider with ChangeNotifier {
  List<Events> allEvents = [];

  bool isEventsStreamFetched = false;

  EventFetchStatus eventFetchStatus = EventFetchStatus.idle;
  Stream<QuerySnapshot>? eventsStream;

  UserProvider userProvider;
  EventsProvider({required this.userProvider}) {
    if (eventFetchStatus != EventFetchStatus.initiated) getAllEventsStream();
  }

  @override
  notifyListeners() {
    if (kDebugMode) {
      print("Notifying listeners");
    }
    super.notifyListeners();
  }

  getAllEventsStream({bool isNotifyListener = true}) async {
    if (userProvider.loggedInUser == null) {
      print("User is null");
      return;
    }

    isEventsStreamFetched = true;
    eventFetchStatus = EventFetchStatus.initiated;
    print("FETCHING EVENTS STREAMMMM");

    eventsStream = db
        .collection('users')
        .doc(userProvider.loggedInUser?.userId)
        .collection('events')
        .orderBy('date', descending: true)
        .snapshots();
    eventsStream!.listen((snapshot) async {
      final List<Events> eventsList = [];

      snapshot.docs.forEach((element) {
        Events eventItem =
            Events.fromMap(element.data() as Map<String, dynamic>);
        eventsList.add(eventItem);
      });
      allEvents.clear();
      allEvents.addAll(eventsList);

      if (isNotifyListener) notifyListeners();

      eventFetchStatus = EventFetchStatus.initiated;
    });
  }

  setUserProvider(
      {required UserProvider userProvider,
      bool isNotifyListener = true}) async {
    this.userProvider = userProvider;
    if (isNotifyListener) notifyListeners();
  }
}
