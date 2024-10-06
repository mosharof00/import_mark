import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../cart/views/cart_view.dart';
import '../../home/views/home_view.dart';
import '../../orders/views/orders_view.dart';
import '../../products/views/products_view.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../profile/views/profile_view.dart';

class MainPageController extends GetxController {
  //TODO: Implement MainPageController
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final count = 0.obs;
  final selectedTab = 0.obs;
  List<TabItem> homeNavItems = [
    TabItem(
      // icon: MdiIcons.home,
      icon: MdiIcons.home,
      title: "Home".tr,
    ),
    TabItem(
      icon: Icons.shopping_cart,
      title: 'Cart'.tr,
    ),
    TabItem(
      icon: MdiIcons.crownOutline,
      title: 'Products'.tr,
    ),
    TabItem(
      icon: Icons.shopping_bag_rounded,
      title: 'My Order'.tr,
    ),
    TabItem(
      icon: Icons.person,
      title: 'Profile'.tr,
    ),
  ];

  List pageList = [
    const HomeView(),
    const CartView(),
    const ProductsView(),
    const OrdersView(),
    const ProfileView(),
  ];

  changeTab(int index) {
    if (index == 3) {
      Get.put(ProfileController()).isAdmin.value = true;
      Get.put(ProfileController()).isFromNaveBar.value = true;
      selectedTab.value = index;
    } else {
      selectedTab.value = index;
    }
  }
}
