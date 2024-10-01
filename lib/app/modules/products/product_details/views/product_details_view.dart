import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_add_to_cart_button/flutter_add_to_cart_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:readmore/readmore.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/awesome_alert_dialog.dart';
import '../../../../../global/custom_svg_image.dart';
import '../../../../../global/shimmer_loading.dart';
import '../../../../../global/text_widgets.dart';
import '../../../../models/foods_product_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../cart/controllers/cart_controller.dart';
import '../controllers/product_details_controller.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    Meal meal = Get.arguments;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorName.bgColor,

        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: ColorName.bgColor,
              pinned: true,
              snap: false,
              floating: false,
              // centerTitle: false,
              titleSpacing: 0,
              expandedHeight: 260.h,
              leading: Padding(
                padding: EdgeInsets.all(10.r),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50.r),
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        shape: BoxShape.circle),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_outlined,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                Obx(
                  () => badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -5, end: -2),
                    showBadge: true,
                    ignorePointer: false,
                    onTap: () {},
                    badgeContent: AppTextStyle(
                      text: cartController.cartedItemsList.length.toString(),
                      color: ColorName.white,
                    ),
                    badgeAnimation: const badges.BadgeAnimation.slide(
                      animationDuration: Duration(seconds: 1),
                      colorChangeAnimationDuration: Duration(seconds: 1),
                      loopAnimation: false,
                      curve: Curves.fastOutSlowIn,
                      colorChangeAnimationCurve: Curves.easeInCubic,
                    ),
                    badgeStyle: badges.BadgeStyle(
                      shape: badges.BadgeShape.circle,
                      badgeColor: Colors.blue,
                      padding: const EdgeInsets.all(5),
                      borderRadius: BorderRadius.circular(4),
                      badgeGradient: const badges.BadgeGradient.linear(
                        colors: [
                          ColorName.gradientStart,
                          ColorName.gradientEnd
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      elevation: 0,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50.r),
                      onTap: () {
                        Get.toNamed(Routes.CART);
                      },
                      child: Container(
                        padding: EdgeInsets.all(3.r),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            shape: BoxShape.circle),
                        child: Center(
                          child: customSvgImage(
                              imagePath: Assets.icons.cartIcon,
                              color: Colors.white,
                              height: 25.h,
                              width: 25.w),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 10.h, bottom: 10.h, right: 10.w),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(5.r),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          shape: BoxShape.circle),
                      child: Center(
                        child: customSvgImage(
                            imagePath: Assets.icons.share,
                            color: Colors.white,
                            height: 18.h,
                            width: 18.w),
                      ),
                    ),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: EdgeInsets.zero,
                background: Hero(
                  tag: meal.idMeal!,
                  child: CachedNetworkImage(
                    height: 300.h,
                    width: Get.width,
                    imageUrl: meal.strMealThumb.toString(),
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        shimmerLoadingWidget(height: 300.h, width: Get.width),
                    errorWidget: (context, url, error) => Image.asset(
                      Assets.images.phoneimage.path,
                      width: Get.width,
                    ),
                  ),
                ),
              ),
            ),

            ///  End of Image part  ///
            SliverList(
                delegate: SliverChildListDelegate([
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.height,
                      AppTextStyle(
                        text: meal.strMeal.toString(),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                      ),
                      5.height,
                      AppTextStyle(
                        text: "Tk.300",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                        textAlign: TextAlign.start,
                      ),
                      // fixedIcon(),
                      divider(),
                      const ReadMoreText(
                        "Introducing Sunrise Berry Blast Smoothie Cubes - the convenient and delicious way to jumpstart your day! Packed with real fruit like tart blueberries, juicy strawberries, and antioxidant-rich raspberries, these pre-portioned cubes are bursting with flavor. Simply pop a handful into your blender with your favorite milk or plant-based alternative, add a touch of honey if desired, and blitz for a refreshing and nutritious smoothie in seconds.",
                        trimMode: TrimMode.Line,
                        trimLines: 2,
                        colorClickableText: ColorName.primaryColor,
                        trimCollapsedText: 'see more',
                        trimExpandedText: 'see less',
                        moreStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorName.primaryColor),
                      ),

                      divider(),
                    ],
                  ),
                ),
              ),
            ]))
          ],
        ),

        ///   BottomNavigationBar  ///

        bottomNavigationBar: Obx(() {
          final productCarted =
              cartController.cartedItemsList.contains(meal.idMeal);
          return Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              10.width,
              // UpdateQuantity(
              //   text: cartController.productQuantity.value,
              //   plusOnTap: () {
              //     cartController.productQuantity.value++;
              //   },
              //   minusOnTap: () {
              //     if (cartController.productQuantity.value > 1) {
              //       cartController.productQuantity.value--;
              //     } else {
              //       Get.snackbar(
              //         "Minimum Limit",
              //         "Can't less then 1",
              //         colorText: ColorName.white,
              //         backgroundColor: ColorName.primaryColor.withOpacity(0.3),
              //         duration: const Duration(seconds: 1),
              //       );
              //     }
              //   },
              //   // isMinusSelected: cartController.isMinusSelected.value,
              // ),
              Padding(
                padding: EdgeInsets.all(8.r),
                child: Obx(() {
                  var con = controller.stateId.obs;
                  return SizedBox(
                    height: 35.h,
                    width: 180.w,
                    child: AddToCartButton(
                      trolley: !productCarted
                          ? const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(
                                Icons.shopping_cart_rounded,
                                color: ColorName.white,
                                size: 30,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(
                                MdiIcons.cartCheck,
                                color: ColorName.white,
                                size: 30,
                              ),
                            ),
                      text: AppTextStyle(
                        text: 'Add to cart',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      check: const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(24),
                      backgroundColor: ColorName.primaryColor,
                      onPressed: (AddToCartButtonStateId id) async {
                        if (id == AddToCartButtonStateId.idle) {
                          //handle logic when pressed on idle state button.
                          Get.find<CartController>().addToCartList(meal);
                          con.value = AddToCartButtonStateId.loading;
                          controller
                              .updateStateId(AddToCartButtonStateId.loading);
                          Future.delayed(const Duration(seconds: 2), () {
                            con.value = AddToCartButtonStateId.done;
                            controller
                                .updateStateId(AddToCartButtonStateId.done);
                            Future.delayed(const Duration(seconds: 2));
                            awesomeAlertDialog(
                                context,
                                DialogType.success,
                                'Awesome! Product Carted',
                                'Want to Continue Shopping',
                                'Go to Cart', () {
                              Get.toNamed(Routes.CART);
                            }, 'Continue', () {}, false);
                          });
                        } else if (id == AddToCartButtonStateId.done &&
                            productCarted) {
                          //handle logic when pressed on done state button.
                          con.value = AddToCartButtonStateId.idle;
                          cartController
                              .updateStateId(AddToCartButtonStateId.idle);
                          controller.cartIndex.value =
                              cartController.cartedItemsList.length;
                          Get.toNamed(Routes.CART);
                        }
                      },
                      stateId: con.value,
                    ),
                  );
                }),
              )
            ],
          );
        }),
      ),
    );
  }
}

Widget fixedIcon() {
  return const Icon(
    Icons.arrow_forward_ios_rounded,
    size: 20,
  );
}
