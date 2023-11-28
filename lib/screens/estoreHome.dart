import 'package:flutter/material.dart';
import 'package:fan_project/models/product.dart';
import 'package:fan_project/screens/productCreationScreen.dart';

class ProductListingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilledButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductCreationScreen()));
            },
            child: Text("Create new product")),

      ],
    );
  }
}