import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/payment_methods_controller.dart';

class PaymentMethodsView extends GetView<PaymentMethodsController> {
  const PaymentMethodsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaymentMethodsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PaymentMethodsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
