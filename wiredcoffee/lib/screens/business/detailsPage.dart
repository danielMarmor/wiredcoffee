import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiredcoffee/providers/cartAsyncProvider.dart';
import 'package:wiredcoffee/providers/loadingIndicatorProvider.dart';
import 'package:wiredcoffee/providers/userProvider.dart';
import 'package:wiredcoffee/shared/widgets/loadedScaffoldBody.dart';
import '../../shared/extensions.dart';

import 'cartPage.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  final String productName;
  final String categoryId;
  final String imageSrc;
  final double price;
  final int? quantity;
  final String? size;
  final Color? color;

  const DetailsPage(
      {super.key,
      required this.id,
      required this.imageSrc,
      required this.productName,
      required this.categoryId,
      required this.price,
      required this.quantity,
      required this.size,
      required this.color});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late int _quantity;
  late String _size;
  late Color _color;

  @override
  void initState() {
    _quantity = widget.quantity ?? 1;
    _size = widget.size ?? "S";
    _color = widget.color ?? Colors.brown;
    // ignore: avoid_print
    super.initState();
  }

  Widget _buildSizeItem(String size) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _size = size;
        });
      },
      child: Container(
        width: 35,
        height: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
                width: 2.0,
                color: size == _size ? Colors.redAccent : Colors.transparent)),
        child: Text(size,
            style: const TextStyle(fontSize: 17.0, color: Colors.black87)),
      ),
    );
  }

  Widget _buildColorItem(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _color = color;
        });
      },
      child: Container(
        width: 62,
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
                width: 2.0,
                color: color.isEquals(_color)
                    ? Colors.redAccent
                    : Colors.transparent)),
        child: Container(
          decoration: BoxDecoration(color: color),
          width: 50,
          height: 45,
        ),
      ),
    );
  }

  Widget _buildProductImage(String imageSrc) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 285,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.imageSrc), fit: BoxFit.contain)),
      ),
    );
  }

  Widget _buildProductName(String name) {
    return Text(name,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500));
  }

  Widget _buildProductPrice(double price) {
    return Text("USD $price",
        style: const TextStyle(
            fontSize: 17, color: Colors.black38, fontWeight: FontWeight.w400));
  }

  Widget _buildProductDescription(String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 10.0,
        ),
        const Text("Description:",
            style: TextStyle(fontSize: 17, color: Colors.black)),
        Text(description,
            style: const TextStyle(fontSize: 15, color: Colors.black45)),
      ],
    );
  }

  Widget _buildProductSize() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15.0,
        ),
        const Text("Size", style: TextStyle(fontSize: 17, color: Colors.black)),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildSizeItem("S"),
              _buildSizeItem("M"),
              _buildSizeItem("L"),
              _buildSizeItem("XL"),
              // _buildSizeItem("XXL"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductColor() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15.0,
        ),
        const Text("Color",
            style: TextStyle(fontSize: 17, color: Colors.black)),
        const SizedBox(
          height: 5.0,
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildColorItem(Colors.brown),
              _buildColorItem(Colors.orangeAccent),
              _buildColorItem(Colors.indigo),
              _buildColorItem(Colors.indigoAccent),
              _buildColorItem(Colors.blueGrey),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildProductQuantity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Quantity",
            style: TextStyle(fontSize: 17, color: Colors.black)),
        const SizedBox(
          width: 25.0,
        ),
        Container(
          width: 175,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.orangeAccent[100],
              borderRadius: BorderRadius.circular(25.0)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_quantity > 1) {
                        _quantity--;
                      }
                    });
                  },
                  child: const Icon(Icons.remove),
                ),
                Text("$_quantity",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                  child: const Icon(Icons.add),
                )
              ]),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CartAsyncProvider>(context, listen: false);
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
      body: LoadedScaffoldBody(
        child: SizedBox(
          width: double.infinity,
          height: 700,
          child: ListView(
            children: <Widget>[
              _buildProductImage(widget.imageSrc),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 60.0,
                          width: 250.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildProductName(widget.productName),
                              const SizedBox(
                                height: 2.5,
                              ),
                              _buildProductPrice(widget.price),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            LoadingIndicatorProvider.loading.value = true;
                            await provider.addCartItem(
                                id: "",
                                productId: widget.id,
                                productName: widget.productName,
                                categoryId: widget.categoryId,
                                image: widget.imageSrc,
                                quantity: _quantity,
                                price: widget.price,
                                color: _color,
                                size: _size);
                            // ignore: use_build_context_synchronously
                            if (!context.mounted) {
                              return;
                            }
                            LoadingIndicatorProvider.loading.value = false;
                            Navigator.of(context, rootNavigator: true)
                                .push(MaterialPageRoute(
                              builder: (context) => const CartPage(),
                            ));
                          },
                          child: Container(
                            width: 55.0,
                            height: 55.0,
                            padding: EdgeInsets.zero,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/fashionPlus.png"),
                            )),
                          ),
                        ),
                      ],
                    ),
                    _buildProductDescription(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting"),
                    _buildProductSize(),
                    _buildProductColor(),
                    const SizedBox(
                      height: 50.0,
                    ),
                    _buildProductQuantity()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
