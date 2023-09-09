import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wiredcoffee/screens/business/authWrapper.dart';
import 'package:wiredcoffee/screens/business/homePage.dart';
import 'package:wiredcoffee/shared/data.dart';

import '../../models/product.dart';
import 'detailsPage.dart';
import 'singleProduct.dart';

class ProductList extends StatelessWidget {
  final String? name;
  final List<ProductModel> products;
  const ProductList({super.key, required this.name, required this.products});

  @override
  Widget build(BuildContext context) {
    List<GestureDetector> gestureDetectors = products.map((product) {
      return GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: (context) => DetailsPage(
                      id: product.id,
                      imageSrc: product.imageSrc,
                      productName: product.name,
                      categoryId: name!,
                      price: product.price,
                      quantity: null,
                      size: null,
                      color: null,
                    )));
          },
          child: SingleProduct(
              imageSrc: product.imageSrc,
              name: product.name,
              price: product.price));
    }).toList();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const AuthWrapper()));
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black)),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.black)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications, color: Colors.black)),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 700,
              child: GridView.count(
                  primary: true,
                  shrinkWrap: true,
                  // padding: const EdgeInsets.only(top: 10.0),
                  crossAxisCount: 2,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 25,
                  childAspectRatio: 150 / 250,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  children: gestureDetectors),
            ),
          ],
        ),
      ),
    ));
  }
}
