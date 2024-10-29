import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:import_mark/app/routes/app_pages.dart';
import 'package:import_mark/global/global_snackbar.dart';
import 'package:import_mark/global/log_printer.dart';
import 'package:import_mark/helper/helper_utils.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Loading button
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  // Is remember me
  RxBool boxCheck = true.obs;
  // Password visibility
  RxBool hidePassword = true.obs;
  // Text Field Controller
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passEditingController = TextEditingController();
  var emailError = ''.obs;
  var passwordError = ''.obs;

  // Sign in method with name fetching
  Future<void> signIn({required String email, required String password}) async {
    try {
      btnController.start();
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        await _firestore.collection('users').doc(user.uid).update({
          'deviceToken': HelperUtils
              .firebaseToken, // Update the push token if it's changed
        });
        String role = userDoc['role'];
        String deviceToken = userDoc['deviceToken'];

        if (role == HelperUtils.admin) {
          await HelperUtils.setUser(
              userId: user.uid, role: role, token: deviceToken);
          Get.offAllNamed(Routes.ADMIN_MAIN_PAGE);
        } else if (role == HelperUtils.user) {
          await HelperUtils.setUser(
              userId: user.uid, role: role, token: deviceToken);
          Get.offAllNamed(Routes.MAIN_PAGE);
        }
        globalSnackBar(
            title: "Success!",
            message: 'Login successfully.',
            durationInSeconds: 2);
      }
      globalSnackBar(
          title: "Unsuccessful!",
          message: 'Something went wrong. please try grain later.',
          durationInSeconds: 2);
      btnController.stop();
    } catch (e) {
      Log.e("Error signing in: $e");
      btnController.stop();
    }
  }

  bool validateInputs() {
    bool isValid = true;
    if (emailEditingController.text.isEmpty) {
      emailError.value = '* Required';
      isValid = false;
    } else if (!GetUtils.isEmail(emailEditingController.text)) {
      emailError.value = 'Enter a valid email';
      isValid = false;
    } else {
      emailError.value = '';
    }
    if (passEditingController.text.isEmpty) {
      passwordError.value = '* Required';
      isValid = false;
    } else {
      passwordError.value = '';
    }
    return isValid;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailEditingController.dispose();
    passEditingController.dispose();
    super.dispose();
  }
}
