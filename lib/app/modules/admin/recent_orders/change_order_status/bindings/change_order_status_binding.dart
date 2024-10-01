import 'package:get/get.dart';

import '../controllers/change_order_status_controller.dart';

class ChangeOrderStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeOrderStatusController>(
      () => ChangeOrderStatusController(),
    );
  }
}
