import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wiredcoffee/models/product.dart';

import '../services/productService.dart';

enum CatalogType { featured, atchieve, coverFeatures, coverAchievs }

// ignore: constant_identifier_names
const int TAKE_MAX = 50;
// ignore: constant_identifier_names
const int TAKE_COVER = 2;

class ProductProvider with ChangeNotifier {
  late List<ProductModel> _achievesProducts = [];
  late List<ProductModel> _fetauredProducts = [];
  ProductProvider();

  Future<void> initData() async {
    await getFeaturedProducts();
    await getArchiveProducts();
    notifyListeners();
  }

  Future<void> getFeaturedProducts() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await ProductService().getFeatures();
    _fetauredProducts = snapshot.docs.map<ProductModel>((doc) {
      return ProductModel(
          id: doc.id,
          imageSrc: doc.data()["image"],
          name: doc.data()["name"],
          price: doc.data()["price"]);
    }).toList();
  }

  Future<void> getArchiveProducts() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await ProductService().getAchieves();
    _achievesProducts = snapshot.docs.map<ProductModel>((doc) {
      return ProductModel(
          id: doc.id,
          imageSrc: doc.data()["image"],
          name: doc.data()["name"],
          price: doc.data()["price"]);
    }).toList();
  }

  List<ProductModel> get featuredProducts => _fetauredProducts;
  List<ProductModel> get achievedProducts => _achievesProducts;
  List<ProductModel> get featuredProductsCover =>
      featuredProducts.take(TAKE_COVER).toList();
  List<ProductModel> get achievedProductsCover =>
      achievedProducts.take(TAKE_COVER).toList();
}
