import 'package:fan_project/estore/productAttributes.dart';
import 'package:fan_project/estore/tempEstore.dart';
import 'package:flutter/material.dart';
import 'package:fan_project/models/product.dart';

import 'attributeTemplates.dart';

class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ProductTypes selectedProductType =
      ProductTypes.clothes; // Default to "clothes"
  Map<String, dynamic> formData = {};

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          DropdownButtonFormField<ProductTypes>(
            value: selectedProductType,
            items: attributeTemplates
                .map((template) => DropdownMenuItem<ProductTypes>(
                      value: template.productType,
                      child: Text(template.productType.name),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedProductType = value!;
              });
            },
          ),
          for (var attribute
              in getAttributesForProductType(selectedProductType))
            buildFormField(attribute),
          FilledButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Create a new product object with the collected data
                Product newProduct = Product(
                  id: UniqueKey().toString(), // Generate a unique ID
                  name: formData['name'],
                  price: formData['price'].toDouble(),
                  description: formData['description'],
                  productType: selectedProductType,
                  attributes: formData,
                );
                // Handle the new product, e.g., save to Firestore
                print(newProduct.toMap());
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget buildFormField(AttributeDetails attribute) {
    if (attribute.type != "enum")
      return TextFormField(
        decoration: InputDecoration(labelText: attribute.label),
        validator: (value) {
          if (attribute.required && (value == null || value.isEmpty)) {
            return 'Please enter ${attribute.label}';
          }
          return null;
        },
        onSaved: (value) {
          formData[attribute.name] = value;
        },
      );
    else {
      List? enumValues = attribute.typeValues;
      var fieldValue = enumValues?.first;
      return DropdownButtonFormField<String>(
        value: fieldValue.toString().split('.').last,
        items: attribute.typeValues!.map((enumValue) {
          return DropdownMenuItem<String>(
            value: enumValue.toString().split('.').last,
            child: Text("${enumValue.toString().split('.').last}"),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            fieldValue = value!;
          });
        },
      );
    }
  }

  List<AttributeDetails> getAttributesForProductType(ProductTypes productType) {
    for (var template in attributeTemplates) {
      if (template.productType == productType) {
        return template.attributes;
      }
    }
    return [];
  }
}
