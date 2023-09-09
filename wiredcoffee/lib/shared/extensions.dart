// ignore_for_file: file_names

import 'package:flutter/material.dart';

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension StringExtension on Color {
  toText() {
    return value.toRadixString(16);
  }

  bool isEquals(Color other) {
    return other.red == red &&
        other.blue == blue &&
        other.green == green &&
        other.alpha == alpha;
  }
}
