import 'package:fan_project/estore/productAttributes.dart';
import 'package:flutter/material.dart';

enum ClothSizes { S, M, L, XL, XXL }

final List<AttributeTemplate> attributeTemplates = [
  AttributeTemplate(
    productType: ProductTypes.clothes,
    attributes: [
      AttributeDetails<ClothSizes>(
        name: "size",
        type: "enum",
        typeValues: ClothSizes.values,
        label: "Size",
        required: true,
      ),
      AttributeDetails(
        name: "color",
        type: "string",
        label: "Color",
        required: true,
      ),
      AttributeDetails(
        name: "image",
        type: "string",
        label: "Material",
        required: false,
      ),
    ],
  ),
  AttributeTemplate(
    productType: ProductTypes.gadgets,
    attributes: [
      AttributeDetails(
        name: "brand",
        type: "string",
        label: "Brand",
        required: true,
      ),
      AttributeDetails(
        name: "screenSize",
        type: "string",
        label: "Screen Size",
        required: true,
      ),
      AttributeDetails(
        name: "batteryLife",
        type: "string",
        label: "Battery Life",
        required: false,
      ),
    ],
  ),
];
