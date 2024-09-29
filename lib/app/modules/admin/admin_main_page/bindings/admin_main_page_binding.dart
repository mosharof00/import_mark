import 'package:get/get.dart';

import '../controllers/admin_main_page_controller.dart';

class AdminMainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminMainPageController>(
      () => AdminMainPageController(),
    );
  }
}
