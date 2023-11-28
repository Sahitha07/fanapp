import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:io';

class ImageViewPopup extends StatefulWidget {
  final String imageUrl;

  ImageViewPopup({required this.imageUrl});

  @override
  _ImageViewPopupState createState() => _ImageViewPopupState();
}

class _ImageViewPopupState extends State<ImageViewPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          PhotoView(
            backgroundDecoration: BoxDecoration(color: Colors.transparent),
            imageProvider: FileImage(File(widget.imageUrl)),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
          Positioned(
            top: 10,
            left: 0,
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(50, 68, 68, 68),
              maxRadius: 30,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close_rounded,
                  size: 30,
                ),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
