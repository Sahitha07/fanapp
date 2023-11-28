import 'dart:io';
import 'dart:typed_data';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan_project/mediaStorage/imageCache.dart';
import 'package:fan_project/providers/eventsProvider.dart';
import 'package:fan_project/providers/userProvider.dart';
import 'package:fan_project/screens/createEventScreen.dart';
import 'package:fan_project/screens/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fan_project/models/event.dart';

import 'package:fan_project/mediaStorage/videoCache.dart';

import 'eventTile.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({Key? key}) : super(key: key);
  @override
  State<EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  late DateTime _selectedDate;
  List<Events> selectedEvents = [];

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now(); // Set it to today's date.
  }

  bool isSameDay(DateTime dateA, DateTime dateB) {
    return dateA.year == dateB.year &&
        dateA.month == dateB.month &&
        dateA.day == dateB.day;
  }

  void _findEventsForSelectedDate(List<Events> events, DateTime date) {
    selectedEvents.clear();
    List<Events> tempEventsList = [];
    events.forEach((event) {
      if (isSameDay(event.date, date)) {
        tempEventsList.add(event);
      }
    });

    setState(() {
      selectedEvents = tempEventsList;
    });
  }

  void _showAllEvents() {
    setState(() {
      selectedEvents = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventsProvider>(
      builder:
          (BuildContext context, EventsProvider eventsProvider, Widget? child) {
        return Stack(
          children: [
            Image.network(
              'https://www.rollingstone.com/wp-content/uploads/2021/05/R1352_FEA_BTS_A_Opener.jpg?w=1024',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            SingleChildScrollView(
              child: Container(
                color: Colors.black, // Set background color
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Schedule',
                            style: TextStyle(
                              color: Color.fromARGB(255, 4, 184, 244),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        FilledButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EventForm()));
                            },
                            child: Row(
                              children: [
                                Text("Create new event"),
                                Icon(Icons.event),
                              ],
                            )),
                      ],
                    ), // Top row
                    MediaQuery(
                      data:
                      MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                      child: CalendarTimeline(
                        showYears: true,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365 * 4)),
                        onDateSelected: (date) {
                          setState(() {
                            _selectedDate = date;
                            _findEventsForSelectedDate(
                                eventsProvider.allEvents, date);
                          });
                        },
                        leftMargin: 20,
                        monthColor: Color.fromARGB(255, 3, 187, 243),
                        dayColor: Color.fromARGB(255, 3, 187, 243),
                        dayNameColor: const Color(0xFF333A47),
                        activeDayColor: Color.fromARGB(255, 205, 200, 200),
                        shrink: false,
                        activeBackgroundDayColor: Colors.redAccent[100],
                        dotsColor: const Color(0xFF333A47),
                        selectableDayPredicate: (date) {
                          return eventsProvider.allEvents.any(
                                  (event) => isSameDay(event.date, date)) ||
                              isSameDay(date, _selectedDate);
                        },
                        locale: 'en',
                      ),
                    ), // Calendar

                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.teal),
                        ),
                        onPressed: () => setState(() => _resetSelectedDate()),
                        child: const Text(
                          'RESET',
                          style: TextStyle(color: Color(0xFF333A47)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Selected date is ${DateFormat('yyyy/MM/dd').format(_selectedDate)}',
                        style:
                        TextStyle(color: Color.fromARGB(255, 32, 180, 165)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _showAllEvents,
                      child: Text('SHOW ALL EVENTS'),
                    ),
                    if (selectedEvents.isEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: eventsProvider.allEvents.length,
                          itemBuilder: (context, index) {
                            return EventTile(
                                event: eventsProvider.allEvents[index]);
                          },
                        ),
                      ),
                    if (selectedEvents.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: selectedEvents.length,
                          itemBuilder: (context, index) {
                            return EventTile(event: selectedEvents[index]);
                          },
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
