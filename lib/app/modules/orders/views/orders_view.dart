import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:import_mark/app/routes/app_pages.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/app_text_style_over_flow.dart';
import '../../../models/foods_product_model.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/orders_controller.dart';
import '../widgets/active_order.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(OrdersController());
    final Meal meal = Get.find<HomeController>().canadianMeals[5];
    const selectColor = ColorName.primaryColor;
    const unselectColor = Colors.black;
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        title: const AppTextStyle(text: 'My Order'),
        centerTitle: true,
        leading: Get.previousRoute == Routes.MAIN_PAGE
            ? const AppTextStyle(
                text: '',
              )
            : InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(Icons.arrow_back),
              ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
            child: Container(
              height: 35.h,
              // width: Get.width,
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black38, blurRadius: 3, offset: Offset(1, 1))
              ]),
              child: Obx(() => TabBar(
                    // physics: const NeverScrollableScrollPhysics(),
                    // padding: const EdgeInsets.only(left: 10, right: 10),
                    indicatorWeight: 0,
                    // labelPadding: const EdgeInsets.only(left: 20, right: 20),
                    tabAlignment: TabAlignment.fill,
                    controller: controller.tabController,
                    dividerColor: Colors.transparent,
                automaticIndicatorColorAdjustment: true,
                labelPadding: const EdgeInsets.all(8),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                            width: 3.w, color: ColorName.primaryColor),
                        insets: EdgeInsets.zero,

                    ),
                    // RectangularIndicator(
                    //   color: ColorName.primaryColor,
                    //   bottomLeftRadius: 50.r,
                    //   // bottomRightRadius: 50.r,
                    //   // topLeftRadius: 50.r,
                    //   topRightRadius: 50.r,
                    //
                    // ),
                    unselectedLabelColor: Colors.black,
                    onTap: (index) {
                      controller.updateSelectedTab(index);
                    },
                    tabs: [
                      AppTextStyle(
                        text:
                            meal == Get.find<HomeController>().canadianMeals[0]
                                ? 'Pending'.tr
                                : 'Pending'.tr,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        height: 0,
                        color: controller.selectedTabIndex.value == 0
                            ? selectColor
                            : unselectColor,
                      ),
                      AppTextStyle(
                        text: 'Completed',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        height: 0,
                        color: controller.selectedTabIndex.value == 1
                            ? selectColor
                            : unselectColor,
                      ),
                      AppTextStyleOverFlow(
                        text: 'Canceled',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        height: 0,
                        color: controller.selectedTabIndex.value == 2
                            ? selectColor
                            : unselectColor,
                      ),
                    ],
                  )),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              // physics: const ClampingScrollPhysics(),
              children: const [ActiveOrders(), ActiveOrders(), ActiveOrders()],
            ),
          )
        ],
      ),
    );
  }
}
