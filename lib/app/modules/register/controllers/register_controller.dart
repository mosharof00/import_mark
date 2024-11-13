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
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
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
  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    Log.i(
        "name: $name\n email : $email \n token: ${HelperUtils.firebaseToken}");
    try {
      btnController.start();
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        // Get the push notification token
        // String? token = await _firebaseMessaging.getToken();
        await _fireStore.collection('users').doc(user.uid).set({
          'id': user.uid,
          'email': email,
          'name': name, // Store user's name
          'role': HelperUtils.user, // 'admin' or 'user'
          'deviceToken':
              HelperUtils.firebaseToken, // Store push notification token
          'password': password,
        });
        DocumentSnapshot userDoc =
            await _fireStore.collection('users').doc(user.uid).get();
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

  /// Google Sign Up
  final FirebaseAuth auth =
      FirebaseAuth.instance; // Initialize Firebase Auth instance
  final Rx<User?> user = Rx<User?>(null); // Reactive user variable
  final GoogleSignIn googleSignIn = GoogleSignIn(); // Initialize Google Sign-In

  Future<void> signUpOrInWithGoogle() async {
    try {
      btnController.start();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        btnController.stop();
        globalSnackBar(
          title: "Google Sign-In Cancelled",
          message: "You did not select an account.",
        );
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      user.value = userCredential.user;

      if (user.value != null) {
        final String? email = user.value!.email;
        final UserInfo? userInfo = user.value!.providerData.isNotEmpty
            ? user.value!.providerData[0]
            : null;
        final String name =
            userInfo?.displayName ?? 'No Name'; // Use a default if name is null
        final String password = user.value!.uid;

        // Check if the user already exists in Firestore
        DocumentSnapshot userDoc =
            await _fireStore.collection('users').doc(user.value!.uid).get();
        if (!userDoc.exists) {
          await _fireStore.collection('users').doc(user.value!.uid).set({
            'id': user.value!.uid,
            'email': email,
            'name': name,
            'role': HelperUtils.admin,
            'deviceToken': HelperUtils.firebaseToken,
            'password': password,
          });
        }

        // Use a more meaningful navigation based on user role
        if (userDoc.exists && userDoc['role'] == HelperUtils.admin) {
          HelperUtils.setUser(
              userId: user.value!.uid,
              role: userDoc['role'],
              token: userDoc['deviceToken']);
          Get.offAllNamed(Routes.ADMIN_MAIN_PAGE);
        } else {
          HelperUtils.setUser(
              userId: user.value!.uid,
              role: userDoc['role'],
              token: userDoc['deviceToken']);
          Get.offAllNamed(Routes.MAIN_PAGE);
        }
      } else {
        await _auth.signOut();
        user.value = null; // Reset user variable
      }
      btnController.stop();
    } catch (e) {
      Log.e(e);
      // Provide user feedback here if necessary
      globalSnackBar(title: "Error!", message: e.toString(),durationInSeconds: 2);
      btnController.stop();
    }
  }

  @override
  void onInit() {
    btnController;
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
