import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_main_page_controller.dart';

class AdminMainPageView extends GetView<AdminMainPageController> {
  const AdminMainPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminMainPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminMainPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
