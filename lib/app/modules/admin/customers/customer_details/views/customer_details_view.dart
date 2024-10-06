import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/customer_details_controller.dart';

class CustomerDetailsView extends GetView<CustomerDetailsController> {
  const CustomerDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomerDetailsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CustomerDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
