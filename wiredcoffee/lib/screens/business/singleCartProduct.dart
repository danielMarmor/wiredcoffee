import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiredcoffee/models/cartItem.dart';
import 'package:wiredcoffee/providers/cartAsyncProvider.dart';
import 'package:wiredcoffee/providers/userProvider.dart';
import 'package:wiredcoffee/shared/extensions.dart';

class SingleCartProduct extends StatefulWidget {
  final String productId;
  final String cartItemId;
  final Color color;
  final String size;
  final bool isInSelectProcess;

  const SingleCartProduct(
      {super.key,
      required this.productId,
      required this.cartItemId,
      // required this.name,
      // required this.imageSrc,
      // required this.quantity,
      // required this.price,
      required this.color,
      required this.size,
      required this.isInSelectProcess});

  @override
  State<SingleCartProduct> createState() => _SingleCartProductState();
}

class _SingleCartProductState extends State<SingleCartProduct> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartAsyncProvider>(
      builder: (context, provider, child) {
        CartItemModel cartItem =
            provider.getSingleItem(widget.productId, widget.color, widget.size);
        return Card(
          elevation: 0.0,
          margin: widget.isInSelectProcess
              ? const EdgeInsets.only(
                  top: 10.0, bottom: 25.0, right: 10.0, left: 10.0)
              : const EdgeInsets.only(
                  top: 10.0, bottom: 0, right: 10.0, left: 10.0),
          color: Colors.white,
          child: SizedBox(
            child: Row(
              children: [
                SizedBox(
                  width: 150.0,
                  height: 150.0,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                  cartItem.image,
                                ))),
                      ),
                      Positioned(
                        top: widget.isInSelectProcess ? 25.0 : 0,
                        left: -3.0,
                        child: Container(
                          width: 25,
                          height: 25,
                          alignment: Alignment.center,
                          child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                await provider.removeCartItem(cartItem.id);
                              },
                              icon: Icon(Icons.delete_forever,
                                  size: 25.0,
                                  color: widget.isInSelectProcess
                                      ? Colors.redAccent
                                      : Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5.0),
                SizedBox(
                    height: 150.0,
                    width: 175.0,
                    child: ListTile(
                      minVerticalPadding: 0,
                      contentPadding: const EdgeInsets.only(left: 10.0),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: widget.isInSelectProcess
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 175.0,
                            height: widget.isInSelectProcess ? 100.0 : 80.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(cartItem.productName,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 18.0, color: Colors.black)),
                                const SizedBox(width: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(cartItem.categoryId.capitalize(),
                                        style: const TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.black54)),
                                    Visibility(
                                      visible: widget.isInSelectProcess,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(widget.size,
                                              style: const TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.black)),
                                          const SizedBox(width: 5.0),
                                          Container(
                                            width: 20,
                                            height: 20,
                                            color: widget.color,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 8.0),
                                Text("USD ${cartItem.price}",
                                    style: const TextStyle(
                                        fontSize: 17.0, color: Colors.black38)),
                              ],
                            ),
                          ),
                          widget.isInSelectProcess
                              ? (Container(
                                  height: 35,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.orangeAccent[100],
                                      borderRadius: BorderRadius.zero),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await provider
                                                .decreaseQty(widget.cartItemId);
                                          },
                                          child: const Icon(
                                            Icons.remove,
                                          ),
                                        ),
                                        Text("${cartItem.quantity}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                        GestureDetector(
                                          onTap: () async {
                                            await provider
                                                .increaseQty(widget.cartItemId);
                                          },
                                          child: const Icon(Icons.add),
                                        )
                                      ]),
                                ))
                              : (Container(
                                  height: 35,
                                  margin: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text("Quantity",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black38,
                                          )),
                                      const SizedBox(
                                        width: 25.0,
                                      ),
                                      Text("${cartItem.quantity}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black38,
                                          )),
                                    ],
                                  )))
                        ],
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
