import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:import_mark/global/sizedbox_extension.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/global_button.dart';
import '../../../models/foods_product_model.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/cart_controller.dart';
import '../widgets/cart_list.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    CartController controller = Get.put(CartController(), permanent: true);
    // final meal = Get.find<HomeController>().canadianMeals.value;
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        title: const AppTextStyle(text: 'Cart'),
        centerTitle: true,
        leading: Get.currentRoute == '/mainpage'
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
      body: Obx(
            () => controller.cartedItemsList.isEmpty
            ? Center(
          child: SvgPicture.asset(
            Assets.icons.cartFillIcon, // There will be empty cart icon
            height: 250.h,
            width: Get.width,
          ),
        )
            : ListView.builder(
          shrinkWrap: true,
          itemCount: controller.cartedItemsList.length,
          itemBuilder: (context, index) {
            final Meal meal = Get.find<HomeController>()
                .canadianMeals
                .firstWhere((p) =>
            p.idMeal ==
                Get.find<CartController>().cartedItemsList[index]);
            // if (controller.cartlistItems.isEmpty) {
            //   return Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       60.height,
            //       ClipRRect(
            //         borderRadius: BorderRadius.circular(50),
            //         child: SvgPicture.asset(
            //           Assets.images.checkout,
            //           height: 250.h,
            //           width: Get.width,
            //         ),
            //       ),
            //       20.height,
            //       Text(
            //         'No Product Carted!'.tr,
            //         textAlign: TextAlign.center,
            //         style: GoogleFonts.montserrat(
            //           textStyle: TextStyle(
            //             color: ColorName.black,
            //             fontSize: 16.sp,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //     ],
            //   );
            // }

            return Obx(
                  () => CartListView(
                meal: meal,
                index: index,
                quantityWidgets: true,
                quantity: controller.productQuantity.value.toString(),
                increaseQuantity: () {
                  controller.productQuantity.value++;
                },
                decreaseQuantity: () {
                  if (controller.productQuantity.value > 1) {
                    controller.productQuantity.value--;
                  } else {
                    Get.snackbar(
                      "Minimum Limit",
                      "Can't less then 1",
                      colorText: ColorName.white,
                      backgroundColor:
                      ColorName.primaryColor.withOpacity(0.3),
                      duration: const Duration(seconds: 1),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Obx(
                () => controller.cartedItemsList.isEmpty
                ? Padding(
              padding: EdgeInsets.all(10.r),
              child: globalButton(
                  onTap: () {
                    // Get.toNamed(Routes.RECOMMENDED_FOR_YOU);
                  },
                  text: "Get foods"),
            )
                : Card(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          13.width,
                          Icon(
                            Icons.money_off,
                            size: 15.sp,
                          ),
                          // customSvgImage(
                          //     imagePath: Assets.icons.dollarIcon,
                          //     height: 16.h,
                          //     width: 16.w,
                          //     color: ColorName.black),
                          5.width,
                          AppTextStyle(
                            text: "24.00",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.CHECKOUT);
                        },
                        child: Container(
                          height: 35.h,
                          width: 180.w,
                          decoration: BoxDecoration(
                              color: ColorName.primaryColor,
                              borderRadius: BorderRadius.circular(50.r)),
                          child: Center(
                            child: AppTextStyle(
                              text: 'Place Order',
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }}