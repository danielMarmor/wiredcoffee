// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:wiredcoffee/shared/extensions.dart';

class CartItemModel {
  final String id;
  final String productId;
  final String productName;
  final String categoryId;
  final String image;
  int quantity;
  final double price;
  final Color color;
  final String size;

  CartItemModel(
      {required this.id,
      required this.productId,
      required this.productName,
      required this.categoryId,
      required this.image,
      required this.quantity,
      required this.price,
      required this.color,
      required this.size});

  double get subTotal => price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'categoryId': categoryId,
      'image': image,
      'quantity': quantity,
      'price': price,
      'color': color.toText(),
      'size': size
    };
  }

  static CartItemModel fromJson(String id, Map<String, dynamic> map) {
    return CartItemModel(
        id: id,
        productId: map['productId'],
        productName: map['productName'],
        categoryId: map['categoryId'],
        image: map['image'],
        quantity: map['quantity'] as int,
        price: map['price'],
        color: (map['color'] as String).toColor(),
        size: map['size']);
  }
}
