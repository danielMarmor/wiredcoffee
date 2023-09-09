import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiredcoffee/providers/productProvider.dart';
import 'package:wiredcoffee/providers/userProvider.dart';
import 'package:wiredcoffee/screens/business/productList.dart';
import 'package:wiredcoffee/shared/data.dart';
import 'package:wiredcoffee/shared/widgets/AppDrawer.dart';
import 'package:wiredcoffee/shared/widgets/categoryItem.dart';
import 'package:wiredcoffee/shared/widgets/imagesView.dart';
import 'package:wiredcoffee/screens/business/singleProduct.dart';
import 'package:wiredcoffee/shared/widgets/productSearch.dart';
import '../../models/product.dart';

import '../../providers/categoryProvider.dart';
import 'detailsPage.dart';

late GlobalKey<ScaffoldState>? _scaffoldKey;

// ignore_for_file: prefer_const_constructors
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

late ProductModel featuredPrimary;
late ProductModel featuredSec;
late ProductModel achievedPrimary;
late ProductModel achievedSec;

class _HomePageState extends State<HomePage> {
  Future<void> initProductProvider() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .getFeaturedProducts();
    // ignore: use_build_context_synchronously
    await Provider.of<ProductProvider>(context, listen: false)
        .getArchiveProducts();
  }

  Widget _buildCategories() {
    return Consumer<CategoryProvider>(
      builder: (context, model, child) {
        return Container(
          width: double.infinity,
          height: 105.0,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  height: 25.0,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'Categories',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              Container(
                height: 80.0,
                width: double.infinity,
                alignment: Alignment.center,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: categories
                        .map(
                          (e) => GestureDetector(
                            child: CategoryItem(imageSrc: e.iconImage),
                            onTap: () async {
                              await model.updateCategory(e.categoryId);
                              // ignore: use_build_context_synchronously
                              if (!context.mounted) {
                                return;
                              }
                              Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                      builder: (context) => ProductList(
                                          name: e.categoryId,
                                          products: model.categoryProducts)));
                            },
                          ),
                        )
                        .toList()),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeatured() {
    return Consumer<ProductProvider>(builder: (context, model, child) {
      //GET PRIMARY
      return SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Featured",
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (ctx) => ProductList(
                              name: 'featured',
                              products: model.featuredProducts)));
                    },
                    child: Text(
                      "View More",
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                width: double.infinity,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: model.featuredProductsCover
                        .map(
                          (e) => GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .push(MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                              id: e.id,
                                              imageSrc: e.imageSrc,
                                              productName: e.name,
                                              categoryId: "featured",
                                              price: e.price,
                                              quantity: null,
                                              size: null,
                                              color: null,
                                            )));
                              },
                              child: SingleProduct(
                                imageSrc: e.imageSrc,
                                name: e.name,
                                price: e.price,
                              )),
                        )
                        .toList()))
          ],
        ),
      );
    });
  }

  Widget _buildAchieves() {
    return Consumer<ProductProvider>(builder: (context, model, child) {
      //GET PRIMARY
      return SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Achieves",
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (ctx) => ProductList(
                              name: 'achieve',
                              products: model.achievedProducts)));
                    },
                    child: Text(
                      "View More",
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                width: double.infinity,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: model.achievedProductsCover
                        .map(
                          (e) => GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .push(MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                              id: e.id,
                                              imageSrc: e.imageSrc,
                                              productName: e.name,
                                              categoryId: "achieve",
                                              price: e.price,
                                              quantity: null,
                                              size: null,
                                              color: null,
                                            )));
                              },
                              child: SingleProduct(
                                imageSrc: e.imageSrc,
                                name: e.name,
                                price: e.price,
                              )),
                        )
                        .toList()))
          ],
        ),
      );
    });
  }

  @override
  void initState() {
    _scaffoldKey = GlobalKey<ScaffoldState>();
    Future.delayed(
      Duration.zero,
      () async {
        var userProv = Provider.of<UserProvider>(context, listen: false);
        await userProv.getUserData();
        // ignore: use_build_context_synchronously
        if (!context.mounted) {
          return;
        }
        var productProv = Provider.of<ProductProvider>(context, listen: false);
        await productProv.initData();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _scaffoldKey = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          drawer: AppDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.grey[100],
            title: const Text(
              'B u r l e s c o n',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            ),
            elevation: 0.0,
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  _scaffoldKey!.currentState!.openDrawer();
                  // Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu, color: Colors.black)),
            actions: <Widget>[
              IconButton(
                  onPressed: () async {
                    showSearch(context: context, delegate: ProductSearch());
                    // if (searchResult != null) {
                    //   // ignore: use_build_context_synchronously
                    //   if (!context.mounted) {
                    //     return;
                    //   }
                    //   final product = searchResult as ProductSearchResult;
                    //   Navigator.of(context, rootNavigator: true)
                    //       .push(MaterialPageRoute(
                    //           builder: (context) => DetailsPage(
                    //                 id: product.id,
                    //                 imageSrc: product.imageSrc,
                    //                 productName: product.name,
                    //                 categoryId: product.categoryId,
                    //                 price: product.price,
                    //                 quantity: null,
                    //                 size: null,
                    //                 color: null,
                    //               )));
                    // }
                  },
                  icon: const Icon(Icons.search, color: Colors.black)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications, color: Colors.black)),
            ],
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              children: [
                //CAROUSEL
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: ImagesView(),
                ),
                const SizedBox(height: 10.0),
                //CATEGORIES
                _buildCategories(),
                //FEATURED
                const SizedBox(height: 5.0),
                _buildFeatured(),
                //ATCHIVES
                const SizedBox(height: 20.0),
                _buildAchieves(),
              ],
            ),
          )),
    );
  }
}
