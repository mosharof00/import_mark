import 'package:get/get.dart';

class PaymentMethodsController extends GetxController {
  //TODO: Implement PaymentMethodsController

  RxInt paymentSelectIndex = 0.obs;

  /// Api
  // final apiService = ApiServices();
  final paymentTypeList = [].obs;
  final selectedPaymentType = 'stripe'.obs;
  final isPartialEnabled = false.obs;
  final partialAmount = '0'.obs;
  // Future<void> getPaymentType() async {
  //   try {
  //     final response = await apiService.getPaymentType(); // Get Payment Methods
  //     paymentTypeList.value = response.data!.type!;
  //     if(response.data!.advancePaymentStatus == 'ON'){
  //       isPartialEnabled.value = true;
  //       partialAmount.value = response.data!.advancePayment!;
  //     }else {
  //       isPartialEnabled.value = false;
  //     }
  //   } catch (e) {
  //     handleException(e);
  //   }
  // }

  @override
  void onInit() {
    // getPaymentType();
    super.onInit();
  }
}
