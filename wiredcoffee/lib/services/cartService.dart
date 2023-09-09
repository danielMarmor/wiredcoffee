// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartService {
  CartService();

  final _database = FirebaseFirestore.instance;

  Future<DocumentReference<Map<String, dynamic>>> insertCart() async {
    final newCart = await _database.collection('carts').add({});
    return newCart;
  }

  Future<void> removeCart(String cartId) async {
    await _database.collection('carts').doc(cartId).delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCartItems(
      String cartId) async {
    final cartItems =
        await _database.collection('carts/$cartId/cartItems').get();
    return cartItems;
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> getCartItemByKeyProps(
      String cartId, String productId, String size, String color) async {
    final snapshot = await _database
        .collection('carts/$cartId/cartItems')
        .where("productId", isEqualTo: productId)
        .where("size", isEqualTo: size)
        .where("color", isEqualTo: color)
        .get();

    final cartItem = snapshot.docs.firstOrNull;
    return cartItem;
  }

  Future<String> addNewCartItem(
      String? cartId, Map<String, dynamic> cartItem) async {
    if (cartId == null) {
      cartId = await insertNewCart(cartItem);
    } else {
      final itemByProps = await getCartItemByKeyProps(
          cartId, cartItem['productId'], cartItem['size'], cartItem['color']);
      if (itemByProps == null) {
        await insertNewCartItem(cartId, cartItem);
      } else {
        final cartItemId = itemByProps.id;
        await updatedCartItem(cartId, cartItemId, cartItem);
      }
    }
    return cartId;
  }

  Future<String> insertNewCart(Map<String, dynamic> firstItem) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final newCartRef = _database.collection('carts').doc();
    newCartRef
        .set({"userId": userId, "creationTime": DateTime.now().toString()});
    final cartItem =
        _database.collection('carts/${newCartRef.id}/cartItems').doc();
    await cartItem.set(firstItem);
    final cartId = newCartRef.id;
    return cartId;
  }

  Future<void> insertNewCartItem(
      String cartId, Map<String, dynamic> map) async {
    await _database.collection('carts/$cartId/cartItems').add(map);
  }

  Future<String?> updatedCartItem(
      String cartId, String cartItemId, Map<String, dynamic> map) async {
    final quantityIncrement = map['quantity'] as int;
    //CART
    final cartRef = _database.collection('carts').doc(cartId);
    //CART ITEMS LIST
    final cartItemsList = _database.collection('carts/$cartId/cartItems');
    final itemsCount = (await cartItemsList.get()).docs.length;
    //CURR CART ITEM
    final cartItemDocRef = cartItemsList.doc(cartItemId);
    final cartItem = await cartItemDocRef.get();
    if (!cartItem.exists) {
      throw Exception("Cart Item $cartItemId Not Found!");
    }
    final currentQuantity = cartItem.data()!['quantity'] as int;
    final updatedQuantity = currentQuantity + quantityIncrement;
    //TRANSACT =>
    final updCartId = await _database.runTransaction((transaction) async {
      if (updatedQuantity <= 0) {
        transaction.delete(cartItemDocRef);
        final newItemsCount = itemsCount - 1;
        if (newItemsCount == 0) {
          transaction.delete(cartRef);
          return null;
        }
        return cartRef.id;
      } else {
        transaction.update(cartItemDocRef, {'quantity': updatedQuantity});
        return cartRef.id;
      }
    });
    return updCartId;
  }

  Future<String?> removeCartItem(String cartId, String cartItemId) async {
    //CART
    final cartRef = FirebaseFirestore.instance.collection('carts').doc(cartId);
    //CART ITEMS
    final cartItemsRef = cartRef.collection('cartItems');
    //REOMVED ITEM
    final cartItemRef = cartItemsRef.doc(cartItemId);
    //ITEMS COUNT
    final cartItemsCount = (await cartItemsRef.get()).docs.length;
    //TRANSACT =>
    final updCartId = await _database.runTransaction((transaction) async {
      transaction.delete(cartItemRef);
      //CHECK IF CHILDREN FOR DOC
      final newItemsCount = cartItemsCount - 1;
      if (newItemsCount == 0) {
        transaction.delete(cartRef);
        return null;
      }
      return cartRef.id;
    });
    return updCartId;
  }
}
