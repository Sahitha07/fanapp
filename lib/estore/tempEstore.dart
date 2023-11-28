import 'package:fan_project/estore/productCreationScreen.dart';
import 'package:flutter/material.dart';
import 'package:fan_project/models/product.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Create product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProductForm(),
      ),
    ),
  ));
}
