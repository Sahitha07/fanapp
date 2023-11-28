import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(FacebookPostsApp());
}

class FacebookPostsApp extends StatelessWidget {
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
  String url = 'https://graph.facebook.com/v18.0/me';
  List<dynamic> posts = [];
  final accessToken =
      'EABa18qcUPrABOxp7VCZAxPRDS2YBPtSEEFZAwVg8StKzpIpxJSl3xUjYHo8myWlz47jZAGSTyk9mtoxd4zZClRpfFNZCJRim5CpkVA2vJpudqB6MWyxT0hDkdrX8UBZBu1vKUVTj1B7TVCDLoqfi8QhZBQZB4qnqOmFuYlrq5xZCsnyRRiJrybSCsZCjfIZCBVZABaqW';
  String userName = '';
  String profilePictureUrl = '';

  @override
  void initState() {
    super.initState();
    fetchFacebookData();
    fetchFacebookPosts();
  }

  Future<void> fetchFacebookData() async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        var dataMap = json.decode(response.body);
        setState(() {
          userName = dataMap['name'] ?? 'Name not available';
          profilePictureUrl =
              dataMap['profile_pic'] ?? 'Default profile picture URL';
        });
      } else {
        // Handle error or invalid response here
        print('Error fetching Facebook data: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors here
      print('Error fetching Facebook data: $error');
    }
  }

  Future<void> fetchFacebookPosts() async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      Map<String, String> queryParams = {
        'fields':
            'id,name,posts{created_time,attachments,message,full_picture,icon,place,shares}',
      };
      String urlWithParams =
          Uri.parse(url).replace(queryParameters: queryParams).toString();
      final response =
          await http.get(Uri.parse(urlWithParams), headers: headers);

      if (response.statusCode == 200) {
        var dataMap = json.decode(response.body);
        List<dynamic> postData = dataMap['posts']['data'] ?? [];

        setState(() {
          posts = List.from(postData.map((post) {
            // Handle the case where 'attachments' is null
            var attachments = post['attachments'] ?? {'data': []};
            var attachmentData = attachments['data'];
            var source = attachmentData.isNotEmpty
                ? attachmentData[0]['media']['source']
                : 'No source available';
            post['source'] = source;
            print(source);
            return post;
          }));
        });
      } else {
        // Handle error or invalid response here
        print('Error fetching Facebook posts: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors here
      print('Error fetching Facebook posts: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook Posts'),
      ),
      // body: ListView.builder(
      //   itemCount: posts.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     var attachment = posts[index]['attachments'] != null
      //         ? posts[index]['attachments']['data'][0]
      //         : null;
      //     print(posts[index]['source']);
      //     return Card(
      //       margin: EdgeInsets.all(8.0),
      //       child: Padding(
      //         padding: EdgeInsets.all(16.0),
      //         child: Column(
      //           children: [
      //             Row(
      //               children: [
      //                 CircleAvatar(
      //                   radius: 25,
      //                   backgroundImage: NetworkImage(profilePictureUrl),
      //                 ),
      //                 SizedBox(width: 10),
      //                 Text(
      //                   userName,
      //                   style: TextStyle(
      //                       fontSize: 16, fontWeight: FontWeight.bold),
      //                 ),
      //               ],
      //             ),
      //             SizedBox(height: 10),
      //             Text(posts[index]['message'] ?? 'No message available'),
      //             SizedBox(height: 10),
      //             Text(posts[index]['created_time'] ?? ''),
      //             SizedBox(height: 10),
      //             attachment != null &&
      //                     attachment['type'] == 'animated_image_share'
      //                 ? Text('Source: ${attachment['source']}')
      //                 : (posts[index]['full_picture'] != null
      //                     ? Text('Source: ${posts[index]['source']}')
      //                     : SizedBox.shrink()),
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
