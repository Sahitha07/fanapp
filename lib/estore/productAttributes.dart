import 'package:flutter/material.dart';

enum ProductTypes { clothes, gadgets, electronics }

class AttributeTemplate {
  final ProductTypes productType;
  final List<AttributeDetails> attributes;

  AttributeTemplate({
    required this.productType,
    required this.attributes,
  });
}

class AttributeDetails<T> {
  final String name;
  final String type;
  List<T>? typeValues;
  final String label;
  final bool required;

  AttributeDetails({
    required this.name,
    required this.type,
    required this.label,
    required this.required,
    this.typeValues,
  });
}
