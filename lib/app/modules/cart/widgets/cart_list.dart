import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:import_mark/app/models/foods_product_model.dart';
import 'package:import_mark/app/modules/cart/controllers/cart_controller.dart';
import 'package:import_mark/global/custom_svg_image.dart';
import 'package:import_mark/global/money_frame.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import 'package:import_mark/global/text_widgets.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/app_text_style_over_flow.dart';
import '../../../../global/shimmer_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../routes/app_pages.dart';

class CartListView extends StatelessWidget {
  const CartListView({
    super.key,
    required this.meal,
    required this.index,
    required this.quantityWidgets,
    this.quantity,
    this.increaseQuantity,
    this.decreaseQuantity,
  });
  final Meal meal;
  final int index;
  final bool quantityWidgets;
  final String? quantity;
  final VoidCallback? increaseQuantity;
  final VoidCallback? decreaseQuantity;

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorName.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(1, 1),
              blurRadius: 1,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: CachedNetworkImage(
                      height: 80.h,
                      width: 80.w,
                      imageUrl: meal.strMealThumb.toString(),
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          shimmerLoadingWidget(height: 70.h, width: 70.w),
                      errorWidget: (context, url, error) => Image.asset(
                        Assets.images.phoneimage.path,
                        width: Get.width,
                      ),
                    ),
                    // ),
                  ),
                  Expanded(
                    // flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 13.w),
                          child: AppTextStyleOverFlow(
                            text: meal.strMeal.toString(),
                            maxLines: 2,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                        5.height,
                        Padding(
                          padding: EdgeInsets.only(left: 13.w),
                          child: moneyFrame(
                            iconColor: ColorName.primaryColor,
                            text: '2.00',
                            textColor: ColorName.primaryColor,
                          ),
                        ),
                        5.height,
                        quantityWidgets == true
                            ? SizedBox(
                                height: 35.h,
                                width: 140.w,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: decreaseQuantity ?? () {},
                                      icon: Container(
                                        height: 20.h,
                                        width: 20.w,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black38,
                                                  blurRadius: 1)
                                            ]),
                                        child: Padding(
                                          padding: EdgeInsets.all(5.r),
                                          child: customSvgImage(
                                              imagePath:
                                                  Assets.icons.minusOutlineIcon,
                                              color: Colors.black,
                                              width: 15.w,
                                              height: 15.h),
                                        ),
                                      ),
                                    ),
                                    AppTextStyle(
                                      text: quantity ?? "1",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp,
                                    ),
                                    IconButton(
                                      onPressed: increaseQuantity ?? () {},
                                      icon: Container(
                                        height: 20.h,
                                        width: 20.w,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black38,
                                                  blurRadius: 1)
                                            ]),
                                        child: Padding(
                                          padding: EdgeInsets.all(5.r),
                                          child: customSvgImage(
                                              imagePath:
                                                  Assets.icons.plusOutlineIcon,
                                              color: Colors.black,
                                              width: 15.w,
                                              height: 15.h),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : 0.width,
                      ],
                    ),
                  ),
                  10.width,
                  quantityWidgets == true
                      ? Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(
                                  Routes.PRODUCT_DETAILS,
                                  arguments: meal,
                                );
                              },
                              child: customSvgImage(
                                  imagePath: Assets.icons.penIcon,
                                  height: 13.h,
                                  width: 13.w,
                                  color: Colors.grey),
                            ),
                            15.width,
                            InkWell(
                              onTap: () {
                                Get.find<CartController>()
                                    .removeToCartList(meal);
                              },
                              child: customSvgImage(
                                  imagePath: Assets.icons.crossIcon,
                                  height: 12.h,
                                  width: 12.w,
                                  color: Colors.grey),
                            )
                          ],
                        )
                      : 0.width,
                ],
              ),
              index == 0
                  ? Column(
                      children: [
                        divider(),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: cartController.extraAddedItemList.length,
                          itemBuilder: (context, item) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 2.h),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AppTextStyle(
                                    text:
                                        cartController.extraAddedItemList[item],
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  const Spacer(),
                                  moneyFrame(
                                    iconColor: ColorName.primaryColor,
                                    text: cartController
                                        .extraAddedItemPrice[item],
                                    textColor: ColorName.primaryColor,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    )
                  : 0.height
            ],
          ),
        ),
      ),
    );
  }
}
