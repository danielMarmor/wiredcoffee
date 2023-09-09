import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiredcoffee/providers/cartAsyncProvider.dart';
import 'package:wiredcoffee/providers/userProvider.dart';
import 'package:wiredcoffee/screens/business/checkoutPage.dart';
import 'package:wiredcoffee/screens/business/singleCartProduct.dart';

import 'detailsPage.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[100],
              elevation: 0.0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black)),
              actions: <Widget>[
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications, color: Colors.black)),
              ],
            ),
            bottomNavigationBar: Container(
                height: 70.0,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(40.0, 10.0, 37.5, 10.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(double.infinity, 50.0),
                        elevation: 0.0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.0))),
                        backgroundColor: Colors.brown[400],
                        foregroundColor: Colors.orangeAccent[100]),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (context) => const CheckoutPage()));
                    },
                    child: const Text("Continue",
                        style: TextStyle(fontSize: 19.0)))),
            body: Consumer<CartAsyncProvider>(
              builder: (context, cart, child) {
                if (cart.itemsCount == 0) {
                  return Center(
                      child: Container(
                    width: 275,
                    height: 275,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/empty-cart.jpg"),
                          fit: BoxFit.fill),
                    ),
                  ));
                }
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 60.0,
                      color: Colors.transparent,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("B u r l e s c o n",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.brown[400])),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${cart.totalAmmount.toStringAsFixed(2)} \$",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.brown[400])),
                              // const SizedBox(width: 5.0),
                              // Icon(Icons.shopping_cart,
                              //     color: Colors.brown[400], size: 50.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 5.0),
                      height: 570,
                      child: ListView(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            //height: 640.0,
                            child: Column(
                                children: cart.cartItems
                                    .map((item) => GestureDetector(
                                          onTap: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailsPage(
                                                          id: item.productId,
                                                          imageSrc: item.image,
                                                          productName:
                                                              item.productName,
                                                          categoryId:
                                                              item.categoryId,
                                                          price: item.price,
                                                          quantity:
                                                              item.quantity,
                                                          size: item.size,
                                                          color: item.color,
                                                        )));
                                          },
                                          child: SingleCartProduct(
                                            cartItemId: item.id,
                                            productId: item.productId,
                                            color: item.color,
                                            size: item.size,
                                            isInSelectProcess: true,
                                          ),
                                        ))
                                    .toList()),
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            )));
  }
}
