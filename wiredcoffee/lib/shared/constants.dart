// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

void showMessage(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

void showSuccessMessage(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.lightGreen,
          ))));
}

String EMPTY = "";
double DISCOUNT_RATE = 0.035;
double SHIPMENT_COST = 16.0;

class RIKeys {
  static final registerKey = GlobalKey<FormState>();
  static final loginKey = GlobalKey<FormState>();
  static final scaffoldKey = const Key('_SCAFFOLD__');
}

const String requestCouldNotCompletedMessage =
    "Your request could not be completed. please contact support!";
