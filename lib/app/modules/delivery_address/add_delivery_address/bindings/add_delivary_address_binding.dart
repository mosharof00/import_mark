import 'package:get/get.dart';

import '../controllers/add_delivary_address_controller.dart';

class AddDeliveryAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDeliveryAddressController>(
      () => AddDeliveryAddressController(),
    );
  }
}
