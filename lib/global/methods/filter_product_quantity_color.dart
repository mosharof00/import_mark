import 'package:flutter/material.dart';

class FilterProductQuantityColor {
  static Color getColor({required int count}) {
    if (count < 20) {
      return Colors.red;
    } else if (count >= 20 && count < 80) {
      return Colors.yellow;
    } else {
      return Colors.black;
    }
  }
}
