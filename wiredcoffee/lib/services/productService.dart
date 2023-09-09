// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wiredcoffee/models/product.dart';

import '../shared/data.dart';

class ProductService {
  ProductService();

  Future<QuerySnapshot<Map<String, dynamic>>> getFeatures() async {
    var features = await FirebaseFirestore.instance
        .collection(featuredCollectionPath)
        .get();
    return features;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAchieves() async {
    var achieves = await FirebaseFirestore.instance
        .collection(achievesCollectionPath)
        .get();
    return achieves;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getProductsByCategory(
      String categoryId) async {
    var snapshot = await FirebaseFirestore.instance
        .collection("category/$categoryId/data")
        .get();
    return snapshot;
  }

  Future<List<ProductSearchResult>> getProductSearch(String query) async {
    final database = FirebaseFirestore.instance;
    final featuresByName = await database
        .collection(featuredCollectionPath)
        .where("name", isGreaterThanOrEqualTo: query)
        .where("name", isLessThan: "${query}z")
        .get();
    final features = featuresByName.docs
        .map((e) => ProductSearchResult(
            id: e.id,
            categoryId: "featured",
            imageSrc: e.data()["image"],
            name: e.data()["name"],
            price: e.data()["price"]))
        .toList();

    // final achivedByName = await database
    //     .collection(achievesCollectionPath)
    //     .where("name", isGreaterThanOrEqualTo: query)
    //     .where("name", isLessThan: "${query}z")
    //     .get();
    // final acheives = achivedByName.docs
    //     .map((e) => ProductSearchResult(
    //         id: e.id,
    //         categoryId: "achieve",
    //         imageSrc: e.data()["image"],
    //         name: e.data()["name"],
    //         price: e.data()["price"]))
    //     .toList();

    //3.CATEGORIES BY PRODUCT NAME
    // final categoriesPromises = categories.map((categ) async {
    //   final categoryItemsByName = await database
    //       .collection("category/${categ.categoryId}/data")
    //       .where("name", isGreaterThanOrEqualTo: query)
    //       .where("name", isLessThan: "${query}z")
    //       .get();
    //   final categoryItems = categoryItemsByName.docs.map((e) {
    //     return ProductSearchResult(
    //         id: e.id,
    //         categoryId: categ.categoryId,
    //         imageSrc: e.data()["image"],
    //         name: e.data()["name"],
    //         price: e.data()["price"]);
    //   }).toList();
    //   return categoryItems;
    // });

    //final categoriesLists = await Future.wait(categoriesPromises);
    //final categoriesProducts = <ProductSearchResult>[];
    //categoriesLists.map((list) => list.map((e) => categoriesProducts.add(e)));

    //final combined = [...features, ...acheives];
    // ignore: avoid_print
    print("combined length=${features.length}");
    return features;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>>? getProductByCategoryAndById(
      String categoryId, String productId) async {
    late DocumentSnapshot<Map<String, dynamic>> snapshot;
    switch (categoryId) {
      case "featured":
        snapshot = await FirebaseFirestore.instance
            .collection("products/featured_products_doc/featured_products")
            .doc(productId)
            .get();
        break;
      case "achieve":
        snapshot = await FirebaseFirestore.instance
            .collection("products/new_achieves_doc/new_achieves")
            .doc(productId)
            .get();
        break;
      default:
        snapshot = await FirebaseFirestore.instance
            .collection("category/$categoryId/data")
            .doc(productId)
            .get();
        break;
    }
    return snapshot;
  }
}
