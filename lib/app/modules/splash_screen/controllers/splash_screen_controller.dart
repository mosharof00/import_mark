import 'package:get/get.dart';

import '../../../../helper/helper_utils.dart';
import '../../../routes/app_pages.dart';
import '../../../services/local_store_config.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

  navigateToMainPage() async {
    ///  get Important token & user ID
    // HelperUtils.token = await HiveService.getToken() ?? "";
    // HelperUtils.adminID = (await HiveService.getAdminID())!;
    // if (HelperUtils.isLogin) {
    //   ///  initialize Main Controllers
    //   await HelperUtils.initializeMainControllers();
    //   await Future.delayed(const Duration(seconds: 3));
    //   Get.offNamed(Routes.MAIN_PAGE);
    // } else {
    //   Future.delayed(Duration.zero, () {
    //     Get.toNamed(Routes.LOGIN);
    //   });
    // }
    await HelperUtils.initializeMainControllers();
    await Future.delayed(const Duration(seconds: 2));
    Get.offNamed(Routes.MAIN_PAGE);
  }

  @override
  void onInit() async {
    navigateToMainPage();
    super.onInit();
  }
}
