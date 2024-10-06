import 'package:flutter/material.dart';

class OrderStatusColor {
  static Color getColor(String status) {
    if (status == 'Pending') {
      return const Color(0xFF7b2cbf);
    } else if (status == 'Confirmed') {
      return const Color(0xFF03045e);
    } else if (status == 'Delivered') {
      return Colors.green;
    } else if (status == 'Canceled') {
      return Colors.red.shade900;
    } else if (status == 'Rejected') {
      return const Color(0xFFff85a1);
    }
    return Colors.grey;
  }
}
