import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:import_mark/app/models/foods_product_model.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/loading_animation_widget.dart';
import '../../../../../global/methods/order_status_color.dart';
import '../../../../../global/not_search_items_found_widget.dart';
import '../../../../../global/server_error_widget.dart';
import '../../../../../global/text_widgets.dart';
import '../../../../../helper/appbar_title.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/recent_orders_controller.dart';
import '../widget/recent_order_list.dart';

class RecentOrdersView extends GetView<RecentOrdersController> {
  const RecentOrdersView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Recent Orders'),
        centerTitle: true,
      ),
      body: Obx(() {
        final test = controller.selectedTabIndex.value;
        return Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            children: [
              SizedBox(
                height: 160.h,
                width: Get.width,

                /// TapBar GridView
                child: MasonryGridView.count(
                  scrollDirection: Axis.horizontal,
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 5.w),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.w,
                  crossAxisSpacing: 10.h,
                  itemCount: controller.orderStatusNameList.length,
                  itemBuilder: (context, index) {
                    // final Product product = controller.productList[index];

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: ScaleAnimation(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15.r),
                          onTap: () {
                            controller.getOrders(index: index);
                            controller.labelContainer.value = 1;
                            controller.selectedTabIndex.value = index;
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(15.r),
                            elevation:
                                controller.selectedTabIndex.value == index
                                    ? 10.r
                                    : 0,
                            shadowColor:
                                controller.selectedTabIndex.value == index
                                    ? controller.orderStatusColorList[index]
                                    : Colors.transparent,
                            child: Container(
                              height: 80.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: controller.orderStatusColorList[index],
                                // boxShadow: [
                                //   BoxShadow(
                                //     color:   controller.selectedTabIndex.value == index ? controller.orderStatusColorList[index]:
                                //         Colors.transparent,
                                //     blurRadius: 3.r,
                                //     offset: Offset(2, 2)
                                //   )
                                // ]
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    controller.orderStatusIconPathList[index],
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                  10.width,
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(() {
                                        if (controller
                                                .adminOrderCountResponseStatus
                                                .value ==
                                            0) {
                                          return AppTextStyle(
                                            text: controller
                                                .adminOrderCountList[index]
                                                .toString(),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18.sp,
                                            color: ColorName.white,
                                          );
                                        } else if (controller
                                                .adminOrderCountResponseStatus
                                                .value ==
                                            1) {
                                          return loadingAnimationWidget(
                                              color: ColorName.white, size: 25);
                                        } else {
                                          return AppTextStyle(
                                            text: Random().nextInt(30).toString(),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12.sp,
                                            color: ColorName.white,
                                          );
                                        }
                                      }),
                                      AppTextStyle(
                                        text: controller
                                            .orderStatusNameList[index],
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.sp,
                                        color: ColorName.white,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              headerText(
                  onPressed: () {
                    Get.toNamed(Routes.ALL_ORDERS)?.then((_) {
                      // controller.fetchData();
                    });
                  },
                  leading: "Recent Orders",
                  // icon: SvgPicture.asset(
                  //   Assets.icons.niceHandIcon,
                  //   height: 15.h,
                  //   width: 15.w,
                  // ),
                  thrilling: "View All"),
              5.height,

              ///        ListView.builder  ///
              NotificationListener(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      controller.isEndPage.value == false &&
                      controller.scrollLoading.value == false &&
                      controller.isEndPage.value == false) {
                    controller.scrollLoading.value = true;
                    // controller.fetchSpecificOrderStatus(
                    //     status: controller.selectedOrderStatus.value,
                    //     page: controller.currentPage.value + 1);
                  }
                  return false;
                },
                child: Expanded(
                  child: Obx(() {
                    if (controller.specificOrderResponseStatus.value == 0) {
                      return controller.orderList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.orderList.length +
                                  (controller.scrollLoading.value ? 1 : 0),
                              itemBuilder: (context, item) {
                                if (item == controller.orderList.length &&
                                    controller.scrollLoading.value) {
                                  return Center(
                                    child: LoadingAnimationWidget.stretchedDots(
                                      size: 40,
                                      color: ColorName.adminPrimaryColor,
                                    ),
                                  );
                                } else {
                                  final Meal order = controller.orderList[item];

                                  return RecentOrderList(
                                    order: order,
                                    onTap: () {
                                      Get.toNamed(Routes.ORDER_INFO,
                                          arguments: {
                                            'order': order,
                                            'status':
                                                controller.selectedStatus.value
                                          })?.then((_) {
                                        // controller.fetchData();
                                      });
                                    },
                                    color: OrderStatusColor.getColor(''),
                                  );
                                }
                              },
                            )
                          : const NotSearchedItemFoundWidget();
                    } else if (controller.specificOrderResponseStatus.value ==
                        1) {
                      return loadingAnimationWidget();
                    } else {
                      return const Expanded(
                        child: ServerErrorWidget(
                          iconHeight: 250,
                        ),
                      );
                    }
                  }),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
