import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:import_mark/helper/helper_utils.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  // Sign up method (with name and notification token)
  Future<void> signUp(
      String email, String password, String name, String role) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        // Get the push notification token
        // String? token = await _firebaseMessaging.getToken();

        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'name': name, // Store user's name
          'role': role, // 'admin' or 'user'
          'deviceToken':
              HelperUtils.firebaseToken, // Store push notification token
        });

        // if (role == 'admin') {
        //   isAdmin.value = true;
        // }

        // userName.value = name; // Update the user's name in the app
      }
    } catch (e) {
      print("Error signing up: $e");
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
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
