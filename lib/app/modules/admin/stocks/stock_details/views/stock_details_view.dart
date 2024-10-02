import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/stock_details_controller.dart';

class StockDetailsView extends GetView<StockDetailsController> {
  const StockDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StockDetailsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StockDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
