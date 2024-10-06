import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../gen/colors.gen.dart';
import '../controllers/main_page_controller.dart';

class MainPageView extends GetView<MainPageController> {
  const MainPageView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(MainPageController());
    return Scaffold(
        bottomNavigationBar: Obx(
              () => BottomBarCreative(
            items: controller.homeNavItems,
            backgroundColor: Colors.white,
            color: Colors.grey,
            colorSelected: ColorName.primaryColor,
            indexSelected: controller.selectedTab.value,
            top: 0,
            isFloating: false,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            highlightStyle: const HighlightStyle(sizeLarge: true, elevation: 8),
            onTap: (index) => controller.changeTab(index),
          ),
        ),
        body: Obx(() => controller.pageList[controller.selectedTab.value]));
  }
}
