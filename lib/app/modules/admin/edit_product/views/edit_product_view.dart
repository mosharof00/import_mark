import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_product_controller.dart';

class EditProductView extends GetView<EditProductController> {
  const EditProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditProductView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditProductView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
