import 'package:flutter/material.dart';

class FullScreenImageView extends StatelessWidget {
  final String imagePath;

  FullScreenImageView({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Screen Image'),
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
        child: Center(
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
