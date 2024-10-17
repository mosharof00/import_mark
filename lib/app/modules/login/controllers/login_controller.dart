import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
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
  Future<void> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        String role = userDoc['role'];
        String name = userDoc['name'];
        // userName.value = name; // Store the user's name for use in the app

        // if (role == 'admin') {
        //   isAdmin.value = true;
        // } else {
        //   isAdmin.value = false;
        // }

        // Update push notification token if needed
        // String? token = await _firebaseMessaging.getToken();
        await _firestore.collection('users').doc(user.uid).update({
          'deviceToken': HelperUtils
              .firebaseToken, // Update the push token if it's changed
        });
      }
    } catch (e) {
      print("Error signing in: $e");
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
