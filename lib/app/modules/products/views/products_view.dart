import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../helper/product_layout.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ProductsController());
    final homeController = Get.put(HomeController());
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        title: const Row(
          children: [
            AppTextStyle(
              text: 'All Products',
            ),
            // SvgPicture.asset(
            //   Assets.icons.niceHandIcon,
            //   height: 15.h,
            //   width: 15.w,
            // ),
          ],
        ),
        centerTitle: true,
      ),
      body: AnimationLimiter(
        child: ScrollWrapper(
          promptAlignment: Alignment.bottomRight,
          enabledAtOffset: 100,
          alwaysVisibleAtOffset: true,
          promptTheme: const PromptButtonTheme(color: ColorName.gray410),
          builder: (context, properties) => MasonryGridView.count(
            controller: controller.scrollController,
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 0,
            itemCount: homeController.recommendedProductList.length,
            itemBuilder: (context, index) {
              final meal = homeController.recommendedProductList[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 500),
                child: ScaleAnimation(
                  child: ProductLayout(
                    meal: meal,
                    onTap: () {
                      Get.toNamed(Routes.PRODUCT_DETAILS, arguments: meal);
                    },
                    height: 250.h,
                    width: Get.width,
                    imageHeight: 180.h,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
