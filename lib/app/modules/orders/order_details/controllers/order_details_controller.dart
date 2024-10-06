import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../payment_methods/controllers/payment_methods_controller.dart';

class OrderDetailsController extends GetxController with GetSingleTickerProviderStateMixin {
  //TODO: Implement OrderDetailsController
  // final RxInt selectedTabIndex = 0.obs;
  late TabController tabController;
  // final picture = Assets.images.phoneimage.path.obs;
  final isSelect = false.obs;
  // late MyOrder myOrder;
  // // late AllOrderStatusList order;
  //
  // //Total Sum
  // late RxInt sum = 0.obs;
  //
  // int totalSum(String subTotal, String shippingChrg, String promos) {
  //   sum.value = (int.parse(subTotal) + int.parse(shippingChrg))- int.parse(promos) ;
  //   return sum.value;
  // }
  // /// Payment Method
  // final paymentController = Get.put(PaymentMethodsController());
  // final gateway = ''.obs;
  // final image = ''.obs;
  // void getPaymentMethod(String method) {
  //   for (var paymentMethod in paymentController.paymentTypeList) {
  //     if (paymentMethod.value == method) {
  //       gateway.value = paymentMethod.status ?? 'Cash On Delivery';
  //       image.value = paymentMethod.image ?? 'Unknown';
  //       return;
  //     }
  //   }
  //   gateway.value = 'Cash On Delivery';
  //   image.value = 'public/backend/images/payment/sslcommerz.png'; // Default image URL
  // }
  //
  // /// Re-Order
  //
  // final apiService = ApiServices();
  // final reOrderData = ReOrder().obs;
  // Future<void> reOrder({required String invoiceID, required String paymentMethod}) async {
  //   try{
  //     final response = await apiService.reOrder(invoiceID, paymentMethod);
  //     if (response.data != null) {
  //       reOrderData.value = response.data!;
  //       String paymentUrl = reOrderData.value.redirectUrl!;
  //       Get.to(() => PaymentWebViewScreen(url: paymentUrl));
  //     } else {
  //       Get.snackbar('Re Order', 'Sorry there has some problem');
  //       Get.offAllNamed(Routes.MAIN_PAGE);
  //       Get.toNamed(Routes.MY_ORDER);
  //     }
  //   }catch(e){
  //     handleException(e);
  //   }
  // }


  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments; //From Active Order
    // myOrder = args['arg1'];
    // order = args ['arg2'];
    // orderProduct = args?['arg2'];
    tabController = TabController(
      length: 2,
      vsync: this,
    );

  }


  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}


class PaymentMethodsModel{
  PaymentMethodsModel({required this.name, required this.image});
 final String name ;
  final String image;
}