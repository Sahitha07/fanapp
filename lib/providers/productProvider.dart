import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];

  void addProduct(Product product) {
    products.add(product);
    notifyListeners();
  }
}
