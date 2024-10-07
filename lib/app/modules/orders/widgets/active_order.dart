import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:import_mark/app/modules/orders/widgets/success_bottom_sheet.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/app_text_style_over_flow.dart';

import '../../../../global/divider.dart';
import '../../../../global/global_button.dart';
import '../../../../global/methods/order_status_color.dart';
import '../../../../global/money_frame.dart';
import '../../../../global/shimmer_loading.dart';
import '../../../../global/staggered_scale_list_animation.dart';
import '../../../../global/text_widgets.dart';
import '../../../models/foods_product_model.dart';
import '../../../routes/app_pages.dart';
import '../../admin/recent_orders/controllers/recent_orders_controller.dart';
import '../../admin/sales_summary/widgets/product_labels.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/orders_controller.dart';
import 'cancel_order_bottom_sheet.dart';

class ActiveOrders extends GetView<OrdersController> {
  const ActiveOrders({super.key});
  @override
  Widget build(BuildContext context) {
    // final Meal meal = Get.find<HomeController>().canadianMeals[5];
    return Obx(() {
      // print(products.toString());

      // return Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     60.height,
      //     ClipRRect(
      //       borderRadius: BorderRadius.circular(50.r),
      //       child: SvgPicture.asset(
      //         Assets.images.emptycart,
      //         height: 250.h,
      //         width: Get.width,
      //       ),
      //     ),
      //     10.height,
      //     // AppTextStyle(text: "No Order Placed!"),
      //     Text(
      //       'No Order Placed!'.tr,
      //       textAlign: TextAlign.center,
      //       style: GoogleFonts.montserrat(
      //         textStyle: TextStyle(
      //           color: ColorName.black,
      //           fontSize: 16.sp,
      //           fontWeight: FontWeight.w500,
      //         ),
      //       ),
      //     ),
      //   ],
      // );
      controller.selectedTabIndex.value;
      return ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          final Meal meal = Get.find<HomeController>().canadianMeals[index];
          return StaggeredScaleListAnimation(
            positionIndex: index,
            child: Padding(
              padding: EdgeInsets.all(10.r),
              child: InkWell(
                onTap: () {
                  Get.toNamed(
                    Routes.ORDER_DETAILS,
                    arguments: meal,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: ColorName.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(1, 1),
                          blurRadius: 1,
                        )
                      ]),
                  child: Padding(
                    padding: EdgeInsets.all(8.0.r),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.shopping_bag,
                              color: Colors.green,
                            ),
                            10.width,
                            AppTextStyle(
                              text: 'Today , 2024',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            const Spacer(),
                            controller.selectedTabIndex.value == 0
                                ? PopupMenuButton(
                                    surfaceTintColor: Colors.white,
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              Assets.icons.forbiddenIcon,
                                              height: 18.h,
                                              width: 18.w,
                                            ),
                                            5.width,
                                            AppTextStyle(
                                              text: "Cancel Order",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          // cancelOrderBottomSheet(
                                          //     context: context,
                                          //     yesOnTap: () {
                                          //       Get.back();
                                          //       successBottomSheet(
                                          //           context: context);
                                          //     },
                                          //     noOnTap: () {
                                          //       Get.back();
                                          //     });
                                          cancelReasonBottomSheet(
                                              context: context,
                                              okOnTap: () {
                                                Get.back();
                                                cancelOrderBottomSheet(
                                                    context: context,
                                                    yesOnTap: () {
                                                      Get.back();
                                                      successBottomSheet(
                                                          context: context);
                                                    },
                                                    noOnTap: () {
                                                      Get.back();
                                                    });
                                              },
                                              noOnTap: () {
                                                Get.back();
                                              });
                                        },
                                      ),
                                    ],
                                  )
                                : controller.selectedTabIndex.value == 1
                                    ? PopupMenuButton(
                                        surfaceTintColor: Colors.white,
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Icon(MdiIcons.cartOff),
                                                5.width,
                                                AppTextStyle(
                                                  text: "Return Order",
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              cancelReasonBottomSheet(
                                                  title: 'Return Reason',
                                                  context: context,
                                                  okOnTap: () {
                                                    Get.back();
                                                    cancelOrderBottomSheet(
                                                        title: 'Return Order',
                                                        context: context,
                                                        subtitle:
                                                            'Are you sure you want to return the order?',
                                                        yesButtonText:
                                                            'Yes, Return Order',
                                                        noButtonText:
                                                            'No, Don\'t Return',
                                                        yesOnTap: () {
                                                          Get.back();
                                                          successBottomSheet(
                                                              text:
                                                                  'Order is being Processed to be Returned',
                                                              context: context);
                                                        },
                                                        noOnTap: () {
                                                          Get.back();
                                                        });
                                                  },
                                                  noOnTap: () {
                                                    Get.back();
                                                  });
                                            },
                                          ),
                                        ],
                                      )
                                    : 0.height,
                          ],
                        ),
                        divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(9.r),
                                  child: CachedNetworkImage(
                                    height: 80.h,
                                    width: 80.w,
                                    imageUrl: meal.strMealThumb.toString(),
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) =>
                                        shimmerLoadingWidget(
                                            height: 70.h,
                                            width: 70.w,
                                            borderRadius: 10.r),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      Assets.images.phoneimage.path,
                                      width: Get.width,
                                    ),
                                  ),
                                  // ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    height: 20.h,
                                    width: 20.w,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorName.primaryColor,
                                    ),
                                    child: Center(
                                      child: AppTextStyle(
                                        text: 2.toString(),
                                        color: ColorName.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 13.w),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextStyleOverFlow(
                                    text: meal.strMeal.toString(),
                                    maxLines: 2,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                  8.height,
                                  moneyFrame(
                                    iconWidth: 18.w,
                                    iconHeight: 18.h,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w800,
                                    iconColor: ColorName.primaryColor,
                                    text: '2.00',
                                    textColor: ColorName.primaryColor,
                                  ),
                                  8.height,
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: 'paid' == "paid"
                                                ? Colors.green
                                                : ColorName.crimsonRed,
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 2.h),
                                          child: const AppTextStyle(
                                            // text: order.paymentStatus!.capitalize.toString(),
                                            text: 'paid',
                                            color: ColorName.white,
                                          ),
                                        ),
                                      ),
                                      50.width,
                                      LabelContainer(
                                        labelTitle:
                                            controller.selectedTabIndex.value ==
                                                    0
                                                ? 'Pending'
                                                : controller.selectedTabIndex
                                                            .value ==
                                                        1
                                                    ? 'Completed'
                                                    : 'Canceled',
                                        containerColor:
                                            OrderStatusColor.getColor(controller
                                                        .selectedTabIndex
                                                        .value ==
                                                    0
                                                ? 'Pending'
                                                : controller.selectedTabIndex
                                                            .value ==
                                                        1
                                                    ? 'Completed'
                                                    : 'Canceled'),

                                        fontSize: 12.sp,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
      );
    });
  }
}
