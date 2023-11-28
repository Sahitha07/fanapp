import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image View'),
        ),
        body: ImageGrid(),
      ),
    );
  }
}

class ImageGrid extends StatefulWidget {
  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  bool showAll = false;

  final List<String> images = [
    'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Y2l0eXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
    'https://www.travelandleisure.com/thmb/91pb8LbDAUwUN_11wATYjx5oF8Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/new-york-city-evening-NYCTG0221-52492d6ccab44f328a1c89f41ac02aea.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBxvydLo1-SUD8A57H7dUVg1StsrmTxBEquQ&usqp=CAU',
    'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?ixlib=rb-4.0.3&ixid=M3xMjA3fDB8MHxzZWFyY2h8NXx8Y2l0eXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
    'https://www.travelandleisure.com/thmb/91pb8LbDAUwUN_11wATYjx5oF8Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/new-york-city-evening-NYCTG0221-52492d6ccab44f328a1c89f41ac02aea.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBxvydLo1-SUD8A57H7dUVg1StsrmTxBEquQ&usqp=CAU',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    final displayedImages = showAll ? images : images.take(4).toList();

    return Column(
      children: [
        Container(
          height: 100,
          child: Image.network(
            displayedImages.first,
            fit: BoxFit.cover,
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: displayedImages.length - 1,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 100,
              child: Image.network(
                displayedImages[index + 1],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ],
    );
  }
}
