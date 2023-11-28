import 'package:fan_project/newsManager/createNews.dart';
import 'package:fan_project/providers/newsProvider.dart';
import 'package:fan_project/providers/userProvider.dart';
import 'package:fan_project/screens/homeScreen.dart';
import 'package:fan_project/screens/mediaUploadScreen.dart';
import 'package:fan_project/utilityFunctions/generateRandom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fan_project/models/news.dart';
import 'package:provider/provider.dart';

class NewsCreationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewsForm();
  }
}

class NewsForm extends StatefulWidget {
  @override
  _NewsFormState createState() => _NewsFormState();
}

class _NewsFormState extends State<NewsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final newsId = generateRandomNewsId();

  @override
  Widget build(BuildContext context) {
    NewsProvider newsProvider = Provider.of<NewsProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Create News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Content'),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter news content';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              FilledButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageUploaderWidget(
                                  onMediaUploaded: (imagesList, videosList) {
                                    NewsCreationManager.imagesList
                                        .addAll(imagesList);
                                    NewsCreationManager.videosList
                                        .addAll(videosList);
                                  },
                                )));
                  },
                  child: Text("Upload Media Files")),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    News news = News(
                        newsId: newsId,
                        title: _titleController.text,
                        description: _contentController.text);
                    bool isNewsCreated = await createNews(
                        news: news,
                        newsProvider: newsProvider,
                        userProvider: userProvider);
                    if (isNewsCreated) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePageScreen()));
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
