import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiredcoffee/providers/cartAsyncProvider.dart';
import 'package:wiredcoffee/screens/business/singleCartProduct.dart';
import 'package:wiredcoffee/shared/constants.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Widget _buildSingleCartProduct(
      String name, String category, String imageSrc, double price) {
    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.only(top: 20.0),
      color: Colors.white,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.black12)),
        ),
        child: Row(
          children: [
            Container(
              width: 150.0,
              height: 125.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(
                        imageSrc,
                      ))),
            ),
            const SizedBox(height: 125.0, width: 0.0),
            SizedBox(
                height: 125.0,
                width: 180.0,
                child: ListTile(
                  minVerticalPadding: 0,
                  contentPadding: const EdgeInsets.only(left: 10.0),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(name,
                          style: const TextStyle(
                              fontSize: 17.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text(category,
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.black54)),
                      Text("USD $price",
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.black38)),
                      const Row(children: [
                        Text("Quantity",
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.black54)),
                        SizedBox(
                          width: 50.0,
                        ),
                        Text("1",
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.black54)),
                      ])
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentItems(String name, String value) {
    return SizedBox(
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(name,
              style: const TextStyle(fontSize: 17.0, color: Colors.black)),
          Text(value,
              style: const TextStyle(fontSize: 17.0, color: Colors.black))
        ],
      ),
    );
  }

  Widget _buildPaymentTotal(String name, String value) {
    return Container(
      height: 40.0,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 2.0, color: Colors.black)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(name,
              style: const TextStyle(
                  fontSize: 17.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          Text(value,
              style: const TextStyle(
                  fontSize: 17.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

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
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.0))),
                        backgroundColor: Colors.orangeAccent[100],
                        foregroundColor: Colors.black),
                    onPressed: () {},
                    child:
                        const Text("Buy", style: TextStyle(fontSize: 19.0)))),
            body: Consumer<CartAsyncProvider>(
              builder: (context, prodiver, child) => Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 60.0,
                    color: Colors.transparent,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("B u r l e s c o n",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.brown[400])),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                "USD ${prodiver.totalAmmount.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black)),
                            const SizedBox(width: 5.0),
                            Icon(Icons.payment,
                                color: Colors.brown[400], size: 50.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 340,
                      child: ListView.separated(
                        itemCount: prodiver.itemsCount,
                        itemBuilder: (context, index) {
                          return SingleCartProduct(
                              productId: prodiver.cartItems[index].productId,
                              cartItemId: prodiver.cartItems[index].id,
                              color: prodiver.cartItems[index].color,
                              size: prodiver.cartItems[index].size,
                              isInSelectProcess: false);
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                      )),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 40.0, right: 20.0, left: 20.0, bottom: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildPaymentItems("Sub Total",
                              "USD ${prodiver.totalAmmount.toStringAsFixed(2)}"),
                          _buildPaymentItems("Discount",
                              "${(DISCOUNT_RATE * 100).toStringAsFixed(2)}%"),
                          _buildPaymentItems("Shipment",
                              "USD ${SHIPMENT_COST.toStringAsFixed(2)}"),
                          _buildPaymentTotal("Total",
                              "USD ${prodiver.netAmmount.toStringAsFixed(2)}")
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
