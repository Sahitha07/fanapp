import 'package:fan_project/estore/productAttributes.dart';

class Product {
  String id;
  String name;
  double price;
  String description;
  ProductTypes productType;
  Map<String, dynamic> attributes;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.productType,
    required this.attributes,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['id'],
        name: map['name'],
        price: map['price'].toDouble(),
        description: map['description'],
        // productType: map['productType'],
        attributes: map['attributes'],
        productType: map['productType'] != null
            ? ProductTypes.values.byName(map['productType'])
            : ProductTypes.clothes);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'productType': productType,
      'attributes': attributes,
    };
  }
}
