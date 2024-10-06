import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import '../../../../../gen/colors.gen.dart';
import '../controllers/admin_main_page_controller.dart';

class AdminMainPageView extends GetView<AdminMainPageController> {
  const AdminMainPageView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(AdminMainPageController());
    return Scaffold(
      // key: controller.scaffoldKey,
        bottomNavigationBar: Obx(
              () => BottomBarDefault(
            items: controller.adminNavBarItems,
            backgroundColor: Colors.white,
            color: Colors.grey,
            colorSelected: ColorName.adminPrimaryColor,
            indexSelected: controller.selectedTab.value,
            top: 15,
            paddingVertical: 20,
            iconSize: 26,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),
              topLeft: Radius.circular(20.r),
            ),
            // highlightStyle: const HighlightStyle(
            //     sizeLarge: true, isHexagon: true, elevation: 6),
            onTap: (index) => controller.changeTab(index),
          ),
        ),
        body: Obx(() => controller.pageList[controller.selectedTab.value])
    );
  }
}
