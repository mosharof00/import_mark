import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/recent_orders_controller.dart';

class RecentOrdersView extends GetView<RecentOrdersController> {
  const RecentOrdersView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecentOrdersView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RecentOrdersView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
