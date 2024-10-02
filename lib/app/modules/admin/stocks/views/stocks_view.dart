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
import '../../../../../global/loading_animation_widget.dart';
import '../../../../../global/methods/filter_product_quantity_color.dart';
import '../../../../../global/server_error_widget.dart';
import '../../../../../helper/appbar_title.dart';
import '../../../../routes/app_pages.dart';
import '../../dashboard/widgets/summary.dart';
import '../controllers/stocks_controller.dart';

class StocksView extends GetView<StocksController> {
  const StocksView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Stocks'),
        centerTitle: true,
      ),
      body: Obx(() {
        final stock = controller.isLoading.value;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.r),
          child: Column(
            children: [
              controller.isLoadingStock.value
                  ? loadingAnimationWidget(size: 40)
                  : const Summary(
                      firstContainerNumber: '1050',
                      firstContainerText: 'Total Stock',
                      secondContainerNumber: '50',
                      secondContainerText: 'Recently Added',
                      thirdContainerNumber: '500',
                      thirdContainerText: 'Sold'),
              Obx(() {
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
                    child: Expanded(
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
                                    vertical: 8.h, horizontal: 2.w),
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.STOCK_DETAILS,
                                        arguments: product);
                                  },
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(15.r),
                                    elevation: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        color: ColorName.white,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          cachedImageHelper(
                                            radius: 15.r,
                                            imgurl: product.strMealThumb!,
                                            imgHeight: 80.h,
                                            imgWidth: 80.w,
                                          ),
                                          5.width,
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: Container(
                                              height: 80.h,
                                              width: 1.w,
                                              color: ColorName.gray70,
                                            ),
                                          ),
                                          5.width,
                                          Expanded(
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
                                                  totalStock:
                                                      Random().nextInt(120),
                                                  color:
                                                      FilterProductQuantityColor
                                                          .getColor(
                                                              count: Random()
                                                                  .nextInt(
                                                                      120)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  );
                } else if (controller.isLoading.value == 1) {
                  return Center(child: loadingAnimationWidget());
                } else {
                  return Expanded(
                    child: ServerErrorWidget(
                      iconHeight: 300.h,
                    ),
                  );
                }
              })
            ],
          ),
        );
      }),
    );
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
