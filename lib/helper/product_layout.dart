import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:import_mark/app/models/foods_product_model.dart';
import 'package:import_mark/global/app_text_style.dart';
import 'package:import_mark/global/sizedbox_extension.dart';
import '../app/routes/app_pages.dart';
import '../gen/assets.gen.dart';
import '../gen/colors.gen.dart';
import '../global/shimmer_loading.dart';
import '../global/text_widgets.dart';

class ProductLayout extends StatelessWidget {
  const ProductLayout(
      {super.key,
      required this.onTap,
      required this.meal,
      this.height,
      this.width,
      this.imageHeight});
  final Meal meal;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final double? imageHeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 280.h,
        width: width ?? 190.w,
        margin: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
            color: ColorName.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1,
                  // spreadRadius: 1,
                  offset: Offset(1, 2))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Hero(
                  tag: Get.currentRoute == Routes.PRODUCT_DETAILS
                      ? "productDetails_${meal.idMeal}"
                      : meal.idMeal.toString(),
                  child: CachedNetworkImage(
                    height: imageHeight ?? 170.h,
                    width: Get.width,
                    imageBuilder: (context, imageProvider) => Container(
                      height: imageHeight ?? 170.h,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    imageUrl: meal.strMealThumb.toString(),
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        shimmerLoadingWidget(height: 160.h, width: Get.width),
                    errorWidget: (context, url, error) => Image.asset(
                      Assets.images.phoneimage.path,
                      width: Get.width,
                    ),
                  ),
                ),
                Positioned(
                  top: 10.h,
                  left: 10.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                        color: ColorName.primaryColor,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Center(
                      child: AppTextStyle(
                        text: 'PROMO',
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            5.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: productTitleText(
                text: meal.strMeal.toString(),
              ),
            ),

            // 5.height,
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // customSvgImage(
                  //     imagePath: Assets.icons.dollarIcon,
                  //     height: 12.h,
                  //     width: 12.w,
                  //     color: Colors.grey),
                  Icon(
                    Icons.money_off,
                    color: ColorName.primaryColor,
                    size: 10.sp,
                  ),
                  productSubtitleText(text: '2.00'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
