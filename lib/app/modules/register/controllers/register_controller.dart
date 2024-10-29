import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:import_mark/app/routes/app_pages.dart';
import 'package:import_mark/global/log_printer.dart';
import 'package:import_mark/helper/helper_utils.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../../../global/global_snackbar.dart';


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
  Future<void> signUp({required String name,required String email, required String password}) async {
    Log.i(
        "name: $name\n email : $email \n token: ${HelperUtils.firebaseToken}");
    try {
      btnController.start();
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password);
      User? user = result.user;

      if (user != null) {
        // Get the push notification token
        // String? token = await _firebaseMessaging.getToken();
        await _firestore.collection('users').doc(user.uid).set({
          'id': user.uid,
          'email': email,
          'name':name, // Store user's name
          'role': HelperUtils.user, // 'admin' or 'user'
          'deviceToken':
              HelperUtils.firebaseToken, // Store push notification token
          'password': password,
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

  // /// Google Sign In
  // final FirebaseAuth auth =
  //     FirebaseAuth.instance; // Initialize Firebase Auth instance
  // final Rx<User?> user = Rx<User?>(null); // Reactive user variable
  // final GoogleSignIn googleSignIn = GoogleSignIn(); // Initialize Google Sign-In
  //
  // Future<void> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //     await googleSignIn.signIn(); // Start Google sign-in flow
  //     if (googleSignInAccount == null) {
  //       btnController.stop();
  //       globalSnackBar(
  //         title: "Google Sign-In Cancelled",
  //         message: "You did not select an account.",
  //       );
  //       return; // Handle case where user cancels sign-in
  //     }
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //     await googleSignInAccount
  //         .authentication; // Get Google authentication tokens
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     ); // Create credential using tokens
  //     final UserCredential userCredential = await auth.signInWithCredential(
  //         credential); // Sign in to Firebase with Google credentialse
  //     user.value = userCredential.user; // Update reactive user variable
  //     if (user.value != null) {
  //       final String? email = user.value!.email; // Get user email
  //       // Retrieve UserInfo from providerData
  //       final UserInfo? userInfo = user.value!.providerData.isNotEmpty
  //           ? user.value!.providerData[0] // Access the first UserInfo
  //           : null;
  //       final String name = userInfo!.displayName!; // Get display name
  //       final String password = user.value!.uid; // Use UID as password
  //       final loginController =
  //       Get.put(LoginController()); // Initialize LoginController
  //       try {
  //         bool status = await loginController.loginUser(
  //           email: email!,
  //           password: password,
  //           isSocial: true,
  //         ); // Attempt login with social credentials
  //         if (!status) {
  //           await registerUser(
  //               name: name,
  //               email: email,
  //               password: password); // Register user if login fails
  //         }
  //       } catch (loginError) {
  //         handleException(loginError); // Handle login errors
  //       }
  //     } else {
  //       await auth.signOut(); // Sign out if user is null
  //       user.value = null; // Reset user variable
  //     }
  //     btnController.stop();
  //   } catch (e) {
  //     Log.e(e);
  //     handleException(e); // Handle sign-in errors
  //   }
  // }
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
