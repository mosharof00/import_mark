import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:import_mark/app/routes/app_pages.dart';
import 'package:import_mark/global/log_printer.dart';
import 'package:import_mark/helper/config.dart';
import 'package:import_mark/helper/helper_utils.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; //
  Rx<User?> firebaseUser = Rx<User?>(null);
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  RxBool isAgree = false.obs;
  RxBool hidePassword = true.obs;
  RxBool hideConfirmPassword = true.obs;

  // Is remember me
  RxBool boxCheck = true.obs;

  /// Password visibility
  // Text Field Controller
  final nameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  // Sign up method (with name and notification token)
  Future<void> signUp() async {
    Log.i(
        "name: ${nameEditingController.text}\n email : ${emailEditingController.text} \n token: ${HelperUtils.firebaseToken}");
    try {
      btnController.start();
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: emailEditingController.text,
          password: passwordEditingController.text);
      User? user = result.user;

      if (user != null) {
        // Get the push notification token
        // String? token = await _firebaseMessaging.getToken();
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': emailEditingController.text,
          'name': nameEditingController.text, // Store user's name
          'role': HelperUtils.user, // 'admin' or 'user'
          'deviceToken':
              HelperUtils.firebaseToken, // Store push notification token
        });
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        HelperUtils.setUser(
            userId: user.uid,
            role: userDoc['role'],
            token: userDoc['deviceToken']);
        Get.offAllNamed(Routes.MAIN_PAGE);
        btnController.stop();
      }
    } catch (e) {
      Log.e("Error signing up: $e");
      btnController.stop();
    }
  }

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
