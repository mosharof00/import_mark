import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:import_mark/app/routes/app_pages.dart';
import 'package:import_mark/global/app_text_style.dart';
import 'package:import_mark/global/global_button.dart';
import 'package:import_mark/global/sizedbox_extension.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckoutView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            20.height,
            const AppTextStyle(text: 'Select Address'),
            10.height,
            globalButton(
                height: 30.h,
                width: 150.w,
                onTap: () {
                  Get.toNamed(Routes.DELIVERY_ADDRESS);
                },
                text: "Address")
          ],
        ),
      ),
    );
  }
}
