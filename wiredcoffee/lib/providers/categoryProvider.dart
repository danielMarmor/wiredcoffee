import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wiredcoffee/models/product.dart';

import '../services/productService.dart';

class CategoryProvider with ChangeNotifier {
  CategoryProvider();

  late String _categoryId;
  late List<ProductModel> _cateogryProducts;

  updateCategory(String categoryId) async {
    _categoryId = categoryId;
    await getCategoryProducts();
    notifyListeners();
  }

  Future<void> getCategoryProducts() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await ProductService().getProductsByCategory(_categoryId);
    _cateogryProducts = snapshot.docs.map<ProductModel>((doc) {
      return ProductModel(
          id: doc.id,
          imageSrc: doc.data()["image"],
          name: doc.data()["name"],
          price: doc.data()["price"]);
    }).toList();
  }

  List<ProductModel> get categoryProducts => _cateogryProducts;
}
