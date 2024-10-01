import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../products/views/products_view.dart';
import '../../../profile/views/profile_view.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../financial/views/financial_view.dart';

class AdminMainPageController extends GetxController {
  //TODO: Implement AdminMainPageController
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final count = 0.obs;
  final selectedTab = 0.obs;
  List pageList = [
    const DashboardView(),
    const FinancialView(),
    const ProductsView(),
    const ProfileView(),
  ];
  ///  Navigate to a specific bottomNavigationBar
  changeTab(int index) {
    // if(index == 2){
    //   Get.put(MainPageController());
    //   final ProductsController productsController =
    //   Get.put(ProductsController());
    //   productsController.isLoading.value = 0;
    //   productsController.fetchProducts(page: null);
    //   selectedTab.value = index;
    // }
    // if(index == 1){
    //   Get.put(MainPageController());
    //   final financialStatusController = Get.put(FinancialStatusController());
    //   financialStatusController.onInit();
    // }
    selectedTab.value = index;
  }

  List<TabItem> adminNavBarItems = [
    TabItem(
      icon: MdiIcons.viewDashboard,
      title: "DashBoard".tr,
    ),
    TabItem(
      icon: MdiIcons.finance,
      title: 'Financial'.tr,
    ),
    TabItem(
      icon: Icons.shopping_cart,
      title: 'All Products'.tr,
    ),
    TabItem(
      icon: Icons.person,
      title: 'Profile'.tr,
    ),
  ];

}
