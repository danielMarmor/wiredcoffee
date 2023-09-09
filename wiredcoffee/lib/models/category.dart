import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wiredcoffee/models/product.dart';

import '../services/productService.dart';

class Category with ChangeNotifier {
  final String categoryId;
  final String categoryName;
  final String iconImage;

  Category(
      {required this.categoryId,
      required this.categoryName,
      required this.iconImage});
}
