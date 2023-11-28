import 'package:fan_project/screens/productDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/productProvider.dart';

class ProductCreationScreen extends StatelessWidget {
  void _getImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // if (pickedFile != null) {
    //   Provider.of<ProductState>(context, listen: false)
    //       .setImage(pickedFile.path, '');
    // }
  }

  void _addImageUrl(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Image URL"),
          content: TextField(
            onChanged: (value) {
              // Provider.of<ProductState>(context, listen: false)
              //     .setImage('', value);
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _getImage(context);
              },
              child: Text('Upload Image'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _addImageUrl(context);
              },
              child: Text('Add Image URL'),
            ),
            SizedBox(height: 10),
            // if (productState.imageUrl.isNotEmpty)
            Image.network(
              '',
              // productState.imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Size'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // _createProduct(context);
              },
              child: Text('Create Product'),
            ),
          ],
        ),
      ),
    );
  }
}
