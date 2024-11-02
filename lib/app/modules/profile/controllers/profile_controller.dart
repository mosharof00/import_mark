import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:import_mark/global/global_snackbar.dart';
import 'package:import_mark/global/log_printer.dart';

import '../../../../helper/helper_utils.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController


  final isAdmin = false.obs;
  final isFromNaveBar = false.obs;


  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Logout method
  Future<void> logout() async {
    try {
      await _auth.signOut();
      HelperUtils.clearUser();
      Get.offAllNamed(Routes.LOGIN);
      Log.i("User logged out successfully");
      globalSnackBar(title: "Log out", message: 'Logged out successfully');
    } catch (e) {
      Log.i("Error logging out: $e");
    }
  }
}
