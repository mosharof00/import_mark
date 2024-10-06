import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:import_mark/app/modules/home/controllers/home_controller.dart';
import 'package:import_mark/global/log_printer.dart';

import '../../../../../gen/assets.gen.dart';

class RecentOrdersController extends GetxController {
  //TODO: Implement RecentOrdersController
  ScrollController scrollController = ScrollController();
  final isScrolling = false.obs;
  final labelContainer = 0.obs;
  final selectedTabIndex = 1.obs;

  /// API Service
  // final apiServices = ApiServices();

  ///  for all/admin  Order Count
  final adminOrderCountResponseStatus =
      100.obs; // status 1 = loading, 2 = error, 0 = get
  final adminOrderCountList = <int>[].obs;

  ///  for pagination
  final currentPage = 0.obs;
  final isEndPage = false.obs;
  final scrollLoading = false.obs;

  /// for all order status get
  final allOrderResponseStatus =
      1.obs; // status 1 = loading, 2 = error, 0 = get
  final allOrderList = [].obs;
  final totalPendingOrders = 0.obs;
  final totalConfirmedOrders = 0.obs;
  final totalCancelledOrders = 0.obs;
  final totalOngoingOrders = 0.obs;
  final totalDeliveredOrders = 0.obs;
  final totalReturnedOrders = 0.obs;

  /// for specific order status
  final selectedOrderStatus = 'Pending'.obs;
  final specificOrderResponseStatus =
      100.obs; // status 1 = loading, 2 = error, 0 = get
  final orderList = [].obs;

  /// static variables
  List<String> orderStatusNameList = [
    "Pending",
    "Confirmed",
    "Delivered",
    "Cancelled",
    "Rejected",
    "Returned",
  ];

  ///   order  status colors
  List<Color> orderStatusColorList = [
    const Color(0xFF7b2cbf),
    const Color(0xFF3a0ca3),
    Colors.green,
    Colors.red.shade900,
    const Color(0xFFff85a1),
    Colors.grey,
  ];

  ///   order  status Icons
  List<String> orderStatusIconPathList = [
    Assets.icons.orderPendingIcon,
    Assets.icons.orderConfirmedIcon,
    Assets.icons.orderDeliveredIcon,
    Assets.icons.orderCancelIcon,
    Assets.icons.orderRejectedIcon,
    Assets.icons.orderReturnedIcon,
  ];

  ///   get order status name
  void getOrders({required int index}) {
    orderList.clear();
    currentPage.value == 0;
    isEndPage.value = false;
    if (index == 0) {
      selectedOrderStatus.value = 'Pending';
      fetchSpecificOrderStatus(status: 'Pending');
      Log.i("Pending Order called");
    } else if (index == 1) {
      selectedOrderStatus.value = 'Confirmed';
      fetchSpecificOrderStatus(status: 'Confirmed');
      Log.i("Confirmed Order called");
    } else if (index == 2) {
      selectedOrderStatus.value = 'Delivered';
      fetchSpecificOrderStatus(status: 'Delivered');
      Log.i("Delivered Order called");
    } else if (index == 3) {
      selectedOrderStatus.value = 'Canceled';
      fetchSpecificOrderStatus(status: 'Canceled');
      Log.i("Canceled Order called");
    } else if (index == 4) {
      selectedOrderStatus.value = 'Rejected';
      fetchSpecificOrderStatus(status: 'Rejected');
      Log.i("Rejected Order called");
    } else if (index == 5) {
      selectedOrderStatus.value = 'Returned';
      fetchSpecificOrderStatus(status: 'Returned');
      Log.i("Returned Order called");
    }
  }

  ///  Fetch Admin Order Count
  // Future<void> fetchAdminOrderCount() async {
  //   adminOrderCountList.clear();
  //   try {
  //     adminOrderCountResponseStatus.value = 1;
  //     final response = await apiServices.adminOrderCount();
  //     adminOrderCountList.add(response.data!.pending!);
  //     adminOrderCountList.add(response.data!.confirmed!);
  //     adminOrderCountList.add(response.data!.ongoing!);
  //     adminOrderCountList.add(response.data!.delivered!);
  //     adminOrderCountList.add(response.data!.canceled!);
  //     adminOrderCountList.add(response.data!.rejected!);
  //     adminOrderCountList.add(response.data!.returned!);
  //     adminOrderCountResponseStatus.value = 0;
  //   } catch (e) {
  //     handleException(e);
  //     adminOrderCountResponseStatus.value = 2;
  //   }
  // }

  final selectedStatus = ''.obs;
   ///  Fetch Specific Order Status
  Future<void> fetchSpecificOrderStatus(
      {required String status, int? page}) async {
    // try {
    //   if (page == null) {
    //     specificOrderResponseStatus.value = 1;
    //     isEndPage.value = false;
    //     currentPage.value = 0;
    //   }
    //
    //   final response =
    //   await apiServices.getAllOrderStatus(status: status, page: page);
    //   if (response.data!.data!.isEmpty) {
    //     isEndPage.value = true;
    //     scrollLoading.value = false;
    //     // return;
    //   }
    //   currentPage.value = response.data!.currentPage!;
    //   orderList.addAll(response.data!.data!);
    //   specificOrderResponseStatus.value = 0;
    //   scrollLoading.value = false;
    // } catch (e) {
    //   handleException(e);
    //   specificOrderResponseStatus.value = 2;
    //   scrollLoading.value = false;
    // }
    selectedStatus.value = status;
    orderList.addAll(Get.find<HomeController>().canadianMeals);
    specificOrderResponseStatus.value = 0;
  }

  ///   fetch data
  void fetchData() {
    orderList.clear();
    currentPage.value == 0;
    isEndPage.value = false;
    // fetchAdminOrderCount();
    fetchSpecificOrderStatus(status: 'Pending');


  }

  @override
  void onInit() {
    fetchData();
    super.onInit();
    scrollController.addListener(() {
      isScrolling.value = scrollController.offset >= 100;
    });
  }
}
