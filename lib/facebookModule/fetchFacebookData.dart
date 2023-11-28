import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String url = 'https://graph.facebook.com/v18.0/me';
List<dynamic> posts = [];
final accessToken =
    'EABa18qcUPrABOxp7VCZAxPRDS2YBPtSEEFZAwVg8StKzpIpxJSl3xUjYHo8myWlz47jZAGSTyk9mtoxd4zZClRpfFNZCJRim5CpkVA2vJpudqB6MWyxT0hDkdrX8UBZBu1vKUVTj1B7TVCDLoqfi8QhZBQZB4qnqOmFuYlrq5xZCsnyRRiJrybSCsZCjfIZCBVZABaqW';
String userName = '';
String profilePictureUrl = '';
Future<void> fetchFacebookData() async {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };

  final response = await http.get(Uri.parse(url), headers: headers);
  // INTEGRATE NEW FACEBOOK FETCH WITH SOURCE
  var dataMap = json.decode(response.body);
  // setState(() {
  //   userName = dataMap['name'];
  //   // profilePictureUrl = dataMap['picture']['data']['url'];
  // });
}

Future<List> fetchFacebookPosts() async {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };

  Map<String, String> queryParams = {
    'fields':
        'id,name,posts{created_time,attachments,message,full_picture,icon,place,shares,id}',
  };
  String urlWithParams =
      Uri.parse(url).replace(queryParameters: queryParams).toString();
  final response = await http.get(Uri.parse(urlWithParams), headers: headers);

  if (response.statusCode == 200) {
    var dataMap = json.decode(response.body);
    List<dynamic> postData = dataMap['posts']['data'] ?? [];

    posts = List.from(postData.map((post) {
      // Handle the case where 'attachments' is null
      var attachments = post['attachments'] ?? {'data': []};
      var attachmentData = attachments['data'] ?? [];
      var media = attachmentData.isNotEmpty ? attachmentData[0]['media'] : [];
      var source = media != null ? media : [];
      var sourceUrl = source != null ? source : 'No source';
      post['source'] = sourceUrl;
      post['attachments'] = attachments;
      // print("POSTTT: ${post}");
      return post;
    }));
  } else {
    // Handle error or invalid response here
    print('Error fetching Facebook posts: ${response.statusCode}');
  }

  return posts;
}

class FacebookPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Facebook Posts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FacebookPostsScreen(),
    );
  }
}

class FacebookPostsScreen extends StatefulWidget {
  @override
  _FacebookPostsScreenState createState() => _FacebookPostsScreenState();
}

class _FacebookPostsScreenState extends State<FacebookPostsScreen> {
  void initState() {
    super.initState();
    fetchFacebookData();
    fetchFacebookPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook Posts'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          var attachment = posts[index]['attachments'] != null
              ? posts[index]['attachments']['data'][0]
              : null;

          return Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(profilePictureUrl),
                      ),
                      SizedBox(width: 10),
                      Text(
                        userName,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(posts[index]['message'] ?? 'No message available'),
                  SizedBox(height: 10),
                  Text(posts[index]['created_time'] ?? ''),
                  SizedBox(height: 10),
                  attachment != null &&
                          attachment['type'] == 'animated_image_share'
                      ? Image.network(attachment['media']['image']['src'])
                      : (posts[index]['full_picture'] != null
                          ? Image.network(posts[index]['full_picture'])
                          : SizedBox.shrink()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
