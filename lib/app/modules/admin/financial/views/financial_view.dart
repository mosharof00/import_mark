import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/financial_controller.dart';

class FinancialView extends GetView<FinancialController> {
  const FinancialView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinancialView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FinancialView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
