import 'package:flutter/material.dart';
import 'dart:io';

import '../../themes/defaultValues.dart';
import 'package:fan_project/screens/imageViewScreen.dart';

class GalleryImageCard extends StatelessWidget {
  GalleryImageCard({super.key, required this.imagePath});
  String imagePath;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: cardBorderRadius,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.fullscreen),
                color: Colors.white,
                onPressed: () {
                  _showImagePopup(context, imagePath);
                },
              ))
        ],
      ),
    );
  }
}

void _showImagePopup(BuildContext context, String imageUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ImageViewPopup(imageUrl: imageUrl);
    },
  );
}
