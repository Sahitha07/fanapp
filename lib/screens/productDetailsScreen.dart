import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fan_project/models/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  '\¥${product.price.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          // if (product.localImagePath.isNotEmpty)
          //   Image.file(
          //     File(product.localImagePath),
          //     height: 200,
          //     width: double.infinity,
          //     fit: BoxFit.cover,
          //   ),
          // if (product.imageUrl.isNotEmpty)
          //   Image.network(
          //     product.imageUrl,
          //     height: 200,
          //     width: double.infinity,
          //     fit: BoxFit.cover,
          //   ),
        ],
      ),
    );
  }
}
