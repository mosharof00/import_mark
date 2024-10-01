import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sales_summary_controller.dart';

class SalesSummaryView extends GetView<SalesSummaryController> {
  const SalesSummaryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SalesSummaryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SalesSummaryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
