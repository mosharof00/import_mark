import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:import_mark/app/modules/admin/dashboard/widgets/summary.dart';
import 'package:import_mark/global/sizedbox_extension.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/loading_animation_widget.dart';
import '../controllers/dashboard_controller.dart';
import 'option_item_lcon_label.dart';

Container homepageBody() {
  final dashBoardController = Get.find<DashboardController>();
  return Container(
    color: Color(0xffdee2e6),
    child: ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      children: [
        const Summary(
            firstContainerNumber: '\$ 120000',
            firstContainerText: 'Today Sell',
            secondContainerNumber: '590',
            secondContainerText: 'Pending',
            thirdContainerNumber: '97',
            thirdContainerText: 'Active Order'),
        10.height,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: optionItem.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (index == 0) {
                  // Get.toNamed(Routes.RECENT_ORDERS);
                } else if (index == 1) {
                  // Get.toNamed(Routes.SALES_SUMMARY);
                } else if (index == 2) {
                  // Get.toNamed(Routes.MY_ORDER);
                } else if (index == 3) {
                  // Get.toNamed(Routes.STOCKS);
                } else if (index == 4) {
                  // Get.toNamed(Routes.ADD_PRODUCT);
                } else if (index == 5) {
                  // final ProductsController productsController =
                  //     Get.put(ProductsController());
                  // productsController.isLoading.value = 0;
                  // productsController.fetchProducts(page: null);
                  // Get.toNamed(Routes.EDIT_PRODUCT);
                } else if (index == 6) {
                  // Get.toNamed(Routes.CUSTOMER);
                } else {
                  // Get.toNamed(Routes.SUPPORT);
                }
              },
              child: ClayContainer(
                curveType: CurveType.concave,
                color: Color(0xffdee2e6),
                borderRadius: 10.r,
                child: OptionItemLabel(
                    title: optionItem[index].title!,
                    icon: optionItem[index].value!),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 120,
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
        )
      ],
    ),
  );
}

class OptionItem {
  final String? title;
  final String? value;

  OptionItem({this.title, this.value});
}

List<OptionItem> optionItem = [
  OptionItem(
    title: 'Recent Orders',
    value: Assets.images.recentorder,
  ),
  OptionItem(
    title: 'Sales Summary',
    value: Assets.images.salesSummary,
  ),
  OptionItem(
    title: 'My Order',
    value: Assets.images.myOrdersIcon,
  ),
  OptionItem(
    title: 'Stocks',
    value: Assets.images.stocks,
  ),
  OptionItem(
    title: 'Add Product',
    value: Assets.images.addProduct,
  ),
  OptionItem(
    title: 'Products',
    value: Assets.images.allproduct,
  ),
  OptionItem(
    title: 'Customers',
    value: Assets.images.customers,
  ),
  OptionItem(
    title: 'Support',
    value: Assets.images.customerSupport,
  ),
];
