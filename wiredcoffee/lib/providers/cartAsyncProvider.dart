// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wiredcoffee/services/cartService.dart';
import 'package:wiredcoffee/services/localStorageService.dart';
import 'package:wiredcoffee/shared/constants.dart';
import '../models/cartItem.dart';

class CartAsyncProvider with ChangeNotifier {
  late String? _cartId;
  late List<CartItemModel> _cartItems;
  CartAsyncProvider();

  List<CartItemModel> get cartItems => _cartItems;

  Future<void> initCart() async {
    //RESET CART
    _cartId = await getStorageCartId();
    //FROM LOCAL STORAGE
    if (_cartId == null) {
      _cartItems = [];
      notifyListeners();
      return;
    }
    //HAS DATA
    await getCartFromSnapshot();
  }

  Future<void> getCartFromSnapshot() async {
    //CANNOT CALL SNAPSHOT WITHOUT CART_ID !
    final cartItemsSnapShot = await CartService().getCartItems(_cartId!);
    final cartData = cartItemsSnapShot.docs.map((doc) {
      final newCartItem = CartItemModel.fromJson(doc.id, doc.data());
      return newCartItem;
    }).toList();
    _cartItems = cartData;
    notifyListeners();
  }

  Future<void> addCartItem(
      {required String id,
      required String productId,
      required String productName,
      required String categoryId,
      required String image,
      required int quantity,
      required double price,
      required Color color,
      required String size}) async {
    //GET DOC IN COLLECTION BY KEY => product_color_size
    //SET ITEM
    final cartItem = CartItemModel(
        id: id,
        productId: productId,
        productName: productName,
        categoryId: categoryId,
        image: image,
        quantity: quantity,
        price: price,
        color: color,
        size: size);
    _cartId = await CartService().addNewCartItem(_cartId, cartItem.toJson());
    await setStorageCartId(_cartId);
    await getCartFromSnapshot();

    //notifyListeners();
  }

  Future<void> removeCartItem(String cartItemId) async {
    if (_cartId == null) {
      throw Exception("Cart Not Found!");
    }
    _cartId = await CartService().removeCartItem(_cartId!, cartItemId);
    await setStorageCartId(_cartId);
    await getCartFromSnapshot();
  }

  Future<String?> getStorageCartId() async {
    final storageCartId =
        await LocalStorageService().getStringFromStorage('cartId');
    return storageCartId;
  }

  CartItemModel getSingleItem(String productId, Color color, String size) {
    CartItemModel? item = cartItems
        .where((element) =>
            element.productId == productId &&
            element.color == color &&
            element.size == size)
        .firstOrNull;
    if (item == null) {
      throw Exception("Item $productId Not Found!");
    }
    return item;
  }

  Future<void> setStorageCartId(String? value) async {
    await LocalStorageService().saveStringToStorage('cartId', value);
  }

  Future<void> increaseQty(String cartItemId) async {
    if (_cartId == null) {
      throw Exception("Cart Not Found!");
    }
    Map<String, dynamic> qtyMap = {'quantity': 1};
    _cartId = await CartService().updatedCartItem(_cartId!, cartItemId, qtyMap);
  }

  Future<void> decreaseQty(String cartItemId) async {
    if (_cartId == null) {
      throw Exception("Cart Not Found!");
    }
    Map<String, dynamic> qtyMap = {'quantity': -1};
    _cartId = await CartService().updatedCartItem(_cartId!, cartItemId, qtyMap);
  }

  int get itemsCount => cartItems.length;
//TOTAL PRICE
  double get totalAmmount => cartItems.fold(
      0,
      (previousValue, element) =>
          previousValue + (element.price * element.quantity));
  double get netAmmount => totalAmmount * (1 - DISCOUNT_RATE) + SHIPMENT_COST;
}
