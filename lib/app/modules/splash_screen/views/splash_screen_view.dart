import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashScreenController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorName.bgColor,
        body: Center(
          // child: Image.asset(
          //   Assets.images.vendorLogo.path,
          //   height: 200.h,
          //   width: 200.w,
          // ),
          child: Image.asset(
            Assets.images.logo.path,
            height: 400.h,
            width: Get.width,
          ),
        ),
      ),
    );
  }
}
