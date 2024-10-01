import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_order_status_controller.dart';

class ChangeOrderStatusView extends GetView<ChangeOrderStatusController> {
  const ChangeOrderStatusView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeOrderStatusView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChangeOrderStatusView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
