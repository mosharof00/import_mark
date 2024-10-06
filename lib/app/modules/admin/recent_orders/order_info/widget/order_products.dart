
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:import_mark/app/models/foods_product_model.dart';
import 'package:import_mark/app/modules/home/controllers/home_controller.dart';
import 'package:import_mark/global/sizedbox_extension.dart';


import '../../../../../../gen/colors.gen.dart';
import '../../../../../../global/app_text_style.dart';
import '../../../../../../global/app_text_style_over_flow.dart';
import '../../../../../../global/cached_network_image_builder.dart';
import '../../../../../../global/divider.dart';
import '../../../../../../global/text_widgets.dart';
import '../../../../cart/widgets/cart_list.dart';


class OrderProducts extends StatelessWidget {
  const OrderProducts({super.key, required this.order});
 final Meal order;
  @override
  Widget build(BuildContext context) {
    return     Container(
      width: Get.width,
      // height: 400.h,
      decoration: BoxDecoration(
        color: ColorName.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            10.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                5.width,
                const Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.green,
                ),
                10.width,
                // (${products.length})
                AppTextStyle(
                  text: 'Your Order',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                // const Spacer(),
                // viewProducts  == true ? InkWell(
                //   onTap: (){
                //     Get.toNamed(Routes.PRODUCTS);
                //   },
                //     child: const Icon(Icons.add)) : 5.width,
              ],
            ),
            10.height,
            divider(),
            5.height,
            ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final Meal meal =
                  Get.find<HomeController>().canadianMeals[index];
                  return CartListView(
                      meal: meal,
                      index: index,
                      quantityWidgets: false);
                })
          ],
        ),
      ),
    );
  }
}
