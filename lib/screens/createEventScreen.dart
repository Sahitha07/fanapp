import 'package:fan_project/eventsManager/createEvent.dart';
import 'package:fan_project/providers/userProvider.dart';
import 'package:fan_project/screens/homeScreen.dart';
import 'package:fan_project/sharedWidgets/creationDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:fan_project/models/event.dart';
import 'package:provider/provider.dart';

import '../utilityFunctions/generateRandom.dart';
import 'mediaUploadScreen.dart';

class EventForm extends StatefulWidget {
  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late DateTime _selectedDate;
  final eventId = generateRandomEventId();
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create new event"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Event Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an event title';
                  }
                  return null;
                },
              ),
              DateTimeField(
                format: DateFormat("yyyy-MM-dd HH:mm"),
                decoration: InputDecoration(labelText: 'Event Date and Time'),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
                onChanged: (selectedDate) {
                  setState(() {
                    _selectedDate = selectedDate!;
                  });
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Event Description:'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter event description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Event Location:'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an event location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              FilledButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageUploaderWidget(
                                  onMediaUploaded: (imagesList, videosList) {
                                    EventCreationManager.imagesList
                                        .addAll(imagesList);
                                    EventCreationManager.videosList
                                        .addAll(videosList);
                                  },
                                )));
                  },
                  child: Text("Upload Media Files")),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Events newEvent = Events(
                        eventId: eventId,
                        title: _titleController.text,
                        date: _selectedDate,
                        description: _descriptionController.text,
                        location: _locationController.text);

                    await createEvent(
                        event: newEvent, userProvider: userProvider);

                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => PopupDialog(
                        title: 'Created Event successfully',
                        description: 'Created event ${newEvent.title}',
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePageScreen()));
                        },
                      ),
                    );
                  }
                },
                child: Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
