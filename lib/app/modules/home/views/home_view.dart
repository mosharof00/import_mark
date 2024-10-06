import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:import_mark/global/sizedbox_extension.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../global/text_widgets.dart';
import '../../../../helper/product_layout.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../widgets/banner.dart';
import '../widgets/home_appbar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), // S
        child: AppBar(
          backgroundColor: ColorName.bgColor,
          surfaceTintColor: ColorName.bgColor,
          flexibleSpace: const HomeAppBar(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(children: [
            headerText(
                onPressed: () {
                  // Get.toNamed(Routes.SPECIAL_OFFERS);
                },
                leading: "Special Offers",
                thrilling: 'See All'),
            8.height,
            const Banners(),
            10.height,
            // Align(
            //   alignment: Alignment.center,
            //   child: Obx(
            //     () => DotsIndicator(
            //       dotsCount: controller.sliderPicture.length,
            //       position: controller.bannerCurrentIndex.value,
            //       decorator: DotsDecorator(
            //         size: Size.square(9.0.sp),
            //         activeSize: Size(18.0.sp, 9.0.sp),
            //         activeColor: ColorName.primaryColor,
            //         activeShape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(5.0)),
            //       ),
            //     ),
            //   ),
            // ),
            15.height,
            headerText(
                onPressed: () {
                  Get.toNamed(Routes.PRODUCTS);
                },
                leading: "Discount Guaranteed!",
                // icon: SvgPicture.asset(
                //   Assets.icons.niceHandIcon,
                //   height: 15.h,
                //   width: 15.w,
                // ),
                thrilling: "See All"),
            SizedBox(
              height: 290.h,
              width: Get.width,
              child: Obx(() {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.recommendedProductList.length,
                    itemBuilder: (context, index) {
                      final meal = controller.recommendedProductList[index];
                      return ProductLayout(
                        meal: meal,
                        onTap: () {
                          Get.toNamed(Routes.PRODUCT_DETAILS, arguments: meal);
                        },
                      );
                    });
              }),
            ),
            5.height,
          ]),
        ),
      ),
    );
  }
}
