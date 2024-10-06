import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:import_mark/app/models/foods_product_model.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import 'package:import_mark/global/staggered_scale_list_animation.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/app_text_style_over_flow.dart';
import '../../../../../global/cached_network_image_builder.dart';
import '../../../../../global/methods/filter_product_quantity_color.dart';
import '../../../../../global/server_error_widget.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/edit_product_controller.dart';

class EditProductView extends GetView<EditProductController> {
  const EditProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorName.bgColor,
        appBar: AppBar(
          backgroundColor: ColorName.bgColor,
          surfaceTintColor: ColorName.bgColor,
          title: const Text('Products'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.offNamed(Routes.ADMIN_MAIN_PAGE);
            },
            icon: const Icon(Icons.arrow_back_sharp),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: Obx(() {
            if (controller.isLoading.value == 0) {
              return NotificationListener(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      controller.isEndPage.value == false &&
                      controller.scrollLoading.value == false &&
                      controller.isEndPage.value == false) {
                    controller.scrollLoading.value = true;
                    controller.fetchProducts(
                        page: controller.currentPage.value + 1);
                  }
                  return false;
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.productList.length +
                      (controller.scrollLoading.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.productList.length &&
                        controller.scrollLoading.value) {
                      return Center(
                        child: LoadingAnimationWidget.stretchedDots(
                          size: 40,
                          color: ColorName.primaryColor,
                        ),
                      );
                    } else {
                      final Meal product = controller.productList[index];
                      return StaggeredScaleListAnimation(
                        positionIndex: index,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 5.w),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.STOCK_DETAILS,
                                  arguments: product);
                            },
                            borderRadius: BorderRadius.circular(15.r),
                            child: Container(
                              height: 100.h,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: ColorName.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(1.w, 1.h),
                                        blurRadius: 1.sp)
                                  ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.r),
                                    child: cachedImageHelper(
                                      radius: 12.r,
                                      imgurl: product.strMealThumb!,
                                      imgHeight: 80.h,
                                      imgWidth: 80.w,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Container(
                                      height: 80.h,
                                      width: 1.w,
                                      color: ColorName.gray70,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.r),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppTextStyleOverFlow(
                                            text: product.strMeal!,
                                            maxLines: 1,
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13.sp,
                                          ),
                                          10.height,
                                          StocksProductId(
                                            id: product.idMeal!,
                                          ),
                                          5.height,
                                          StocksProductText(
                                            totalStock: Random().nextInt(120),
                                            color: FilterProductQuantityColor
                                                .getColor(
                                                    count:
                                                        Random().nextInt(120)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  PopupMenuButton<int>(
                                    onSelected: (value) {
                                      // Handle button selection
                                      switch (value) {
                                        case 0:
                                          Get.toNamed(Routes.ADD_PRODUCT,
                                              arguments: {'product': product});

                                          break;
                                        case 1:
                                          debugPrint('Button 2 clicked');
                                          break;
                                        case 2:
                                          debugPrint('Button 3 clicked');
                                          break;
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem<int>(
                                        value: 0,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              size: 14.sp,
                                            ),
                                            5.width,
                                            AppTextStyle(
                                              text: 'Edit',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem<int>(
                                        value: 1,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: Colors.green,
                                              size: 12.sp,
                                            ),
                                            5.width,
                                            AppTextStyle(
                                              text: 'Active',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem<int>(
                                        value: 2,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: Colors.grey,
                                              size: 12.sp,
                                            ),
                                            5.width,
                                            AppTextStyle(
                                              text: 'Inactive',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                    icon: const Icon(Icons
                                        .more_vert), // You can replace it with any icon or widget
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              );
            } else if (controller.isLoading.value == 1) {
              return Center(
                child: LoadingAnimationWidget.stretchedDots(
                  size: 40,
                  color: ColorName.primaryColor,
                ),
              );
            } else {
              return Expanded(
                child: ServerErrorWidget(
                  iconHeight: 300.h,
                ),
              );
            }
          }),
        ));
  }
}

class StocksProductText extends StatelessWidget {
  const StocksProductText({
    super.key,
    required this.totalStock,
    required this.color,
  });

  final int totalStock;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          MdiIcons.storePlusOutline,
          size: 20,
        ),
        10.width,
        AppTextStyle(
          text: "${totalStock.toString()} (${'Total'.tr})",
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ],
    );
  }
}

class StocksProductId extends StatelessWidget {
  const StocksProductId({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          MdiIcons.identifier,
          size: 25,
        ),
        5.width,
        AppTextStyle(
            text: id,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey),
      ],
    );
  }
}
