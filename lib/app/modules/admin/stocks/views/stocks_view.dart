import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/stocks_controller.dart';

class StocksView extends GetView<StocksController> {
  const StocksView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StocksView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StocksView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
