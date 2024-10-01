import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../../../../../gen/colors.gen.dart';
import '../../../../../../global/global_snackbar.dart';
import '../../../../payment_methods/controllers/payment_methods_controller.dart';

class OrderInfoController extends GetxController {
  //TODO: Implement OrderInfoController

  ScrollController scrollController = ScrollController();
  RoundedLoadingButtonController roundedLoadingButtonController =
  RoundedLoadingButtonController();
  final isVisible = false.obs;
  // ApiServices apiServices = ApiServices();
  ///   for copy invoiceID   using 'clipboard' package
  final isSelect = false.obs;

  ///  Total Sum
  late RxInt sum = 0.obs;

  ///  calculate total sum of total ordered product amount
  int totalSum(String subTotal, String shippingCharge, String promos) {
    sum.value =
        (int.parse(subTotal) + int.parse(shippingCharge)) - int.parse(promos);
    return sum.value;
  }

  /// for order
  final order = [].obs;
  final orderResponseStatus = 100.obs;

  /// for change order Status
  // final changeAdminOrderStatus = ChangeAdminOrderStatusModel().obs;
  final newStatus = "".obs;
  final changeOrderResponseStatus = 0.obs;

  /// Payment Method
  final paymentController = Get.put(PaymentMethodsController());
  final gateway = ''.obs;
  final image = ''.obs;
  void getPaymentMethod(String method) {
    for (var paymentMethod in paymentController.paymentTypeList) {
      if (paymentMethod.value == method) {
        gateway.value = paymentMethod.status ?? 'Cash On Delivery';
        image.value = paymentMethod.image ?? 'Unknown';
        return;
      }
    }
    gateway.value = 'Cash On Delivery';
    image.value =
    'public/backend/images/payment/sslcommerz.png'; // Default image URL
  }

  // Future<void> launchGoogleMaps() async {
  //   final Uri googleMapsUri =
  //   Uri.parse('https://maps.app.goo.gl/dDXc5Md4roTYSk9F9');
  //   if (await canLaunchUrl(googleMapsUri)) {
  //     await launchUrl(googleMapsUri);
  //   } else {
  //     throw 'Could not launch $googleMapsUri';
  //   }
  // }

  ///  get im_stepper position
  RxInt activeStep = 0.obs;
  void updateActiveStep({required String status}) {
    switch (status) {
      case 'Pending':
        activeStep.value = 0;
        break;
      case 'Confirmed':
        activeStep.value = 1;
        break;
      case 'Delivered':
        activeStep.value = 3;
        break;
    }
  }

  ///  get im_stepper status color
  Color headerColor() {
    switch (activeStep.value) {
      case 0:
        return const Color(0xFF7b2cbf);
      case 1:
        return const Color(0xFF3a0ca3);
      case 2:
        return ColorName.green;
    }
    return Colors.grey;
  }

  ///   on status change floatingActionButton status color
  Color buttonColor() {
    switch (activeStep.value) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.green;
      case 2:
        return ColorName.adminPrimaryColor;
    }
    return Colors.grey;
  }

  ///   on status change floatingActionButton status text
  String buttonText() {
    switch (activeStep.value) {
      case 0:
        return 'Accept';
      case 1:
        return 'Delivered';
      case 2:
        return 'Done';
    }
    return 'Exception';
  }

  ///  Fetch  Change Admin Order  Status
  Future<void> fetchChangeAdminOrderStatus(
      {required String invoiceId, required String status}) async {
    // try {
    //   changeOrderResponseStatus.value = 1;
    //   final response = await apiServices.changeAdminOrderStatus(
    //       invoiceID: invoiceId, status: status);
    //   changeAdminOrderStatus.value = response;
    //   activeStep.value++;
    //   newStatus.value = response.data!.status!;
    //   changeOrderResponseStatus.value = 0;
    //   globalSnackBar(title: "Success!", message: " Status changed");
    // } catch (e) {
    //   handleException(e);
    //   changeOrderResponseStatus.value = 2;
    // }
    activeStep.value++;
    newStatus.value = newStatus.value == 'Confirmed'
        ? 'Delivered'
        : 'Pending';
      changeOrderResponseStatus.value = 0;
      globalSnackBar(title: "Success!", message: " Status changed");
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    scrollController.addListener(() {
      isVisible.value =
          scrollController.offset == scrollController.position.maxScrollExtent;
    });
  }
}
