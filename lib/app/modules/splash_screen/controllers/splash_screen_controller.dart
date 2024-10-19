import 'package:get/get.dart';

import '../../../../global/log_printer.dart';
import '../../../../helper/config.dart';
import '../../../../helper/helper_utils.dart';
import '../../../../helper/hive_service.dart';
import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

  Future<void> navigateToHomePage() async {
    HelperUtils.userID = await HiveService.getUserID() ?? "";
    HelperUtils.userRole = await HiveService.getUserRole() ?? "";
    HelperUtils.token = await HiveService.getToken() ?? "";
    final hasOnBoardBeenShown = await HiveService.getOnBoardShowed();
    Log.i(
        'user id:${HelperUtils.userID} \nuserRole: ${HelperUtils.userRole}  \nuserToken: ${HelperUtils.token}');
    if (HelperUtils.userID.isEmpty ||
        HelperUtils.token.isEmpty ||
        HelperUtils.userRole.isEmpty) {
      if (hasOnBoardBeenShown) {
        Get.offNamed(Routes.LOGIN);
      } else {
        Get.offNamed(Routes.ONBOARD);
      }
    } else {
      if (HelperUtils.userRole == HelperUtils.user) {
        ///  for Student
        AppConfig.appFlavor = AppFlavor.user;
        // HelperUtils.initializeStudentMainControllers();
        await Future.delayed(const Duration(seconds: 2));
        Get.offNamed(Routes.MAIN_PAGE);
      } else if (HelperUtils.userRole == HelperUtils.admin) {
        ///  for Instructor
        AppConfig.appFlavor = AppFlavor.admin;
        // HelperUtils.initializeMentorMainControllers();
        await Future.delayed(const Duration(seconds: 2));
        Get.offNamed(Routes.ADMIN_MAIN_PAGE);
      } else {
        ///  for Unauthenticated/Guest  user
        Get.offNamed(Routes.LOGIN);
      }
    }
  }

  @override
  void onInit() async {
    navigateToHomePage();
    super.onInit();
  }
}
