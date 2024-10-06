import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController with GetSingleTickerProviderStateMixin{
  //TODO: Implement OrdersController
  // final picture = Assets.images.foodDelivery.path.obs;
  RxInt selectedTabIndex = 0.obs;
  late TabController tabController;
  RxInt activeStep = 4.obs;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  String headerText() {
    switch (activeStep.value) {
      case 1:
        return 'Reached our Facility';
      case 2:
        return 'Shipped';
      case 3:
        return 'Order Delivery';
      case 4:
        return 'Order Confirmed';
      default:
        return 'Introduction';
    }
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    // tabController.addListener(() {
    //   selectedTabIndex.value = tabController.index;
    // });
  }

  void updateSelectedTab(int index) {
    selectedTabIndex.value = index;
    tabController.animateTo(index);
    update();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

//   For Cancel Order
  RxInt  selectedReasonOptionIndex = 0.obs;
  final List<String> cancelReasonsList = [
    "Want to place a New order with more/different items.",
    "Delivery item is too long",
    "Duplicate order",
    "Shopping const is too high",
    "Change of delivery address",
    "Forgot to use voucher/promos issue",
  ];
}
