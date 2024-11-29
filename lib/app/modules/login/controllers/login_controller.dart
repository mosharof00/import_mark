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
  Future<void> logIn({required String email, required String password}) async {
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
        btnController.stop();
        globalSnackBar(
            title: "Success!",
            message: 'Login successfully.',
            durationInSeconds: 2);
      }else{
        btnController.stop();
        globalSnackBar(
            title: "Unsuccessful!",
            message: 'Something went wrong. please try grain later.',
            durationInSeconds: 2);
      }
    } on FirebaseAuthException catch (e) {
      btnController.stop();
      // Handle different FirebaseAuth errors
      String errorMessage;

      switch (e.code) {
        case 'invalid-email':
          errorMessage = "The email address is not valid.";
          break;
        case 'user-disabled':
          errorMessage = "This user has been disabled.";
          break;
        case 'user-not-found':
          errorMessage = "No user found with this email.";
          break;
        case 'wrong-password':
          errorMessage = "Incorrect password provided.";
          break;
        default:
          errorMessage = "Login failed. Please try again.";
      }
      globalSnackBar(title: 'Error!', message: errorMessage);
    } catch (e) {
      btnController.stop();
      Log.e(e);
    } finally {
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
  //     btnController.start();
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await googleSignIn.signIn(); // Start Google sign-in flow
  //     if (googleSignInAccount == null) {
  //       btnController.stop();
  //       globalSnackBar(
  //         title: "Google Sign-In Cancelled",
  //         message: "You did not select an account.",
  //       );
  //       return; // Handle case where user cancels sign-in
  //     }
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount
  //             .authentication; // Get Google authentication tokens
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
  //
  //       ///   set  user into firebase
  //      await signIn(email: email!, password: password);
  //     } else {
  //       await auth.signOut(); // Sign out if user is null
  //       user.value = null; // Reset user variable
  //     }
  //     btnController.stop();
  //   } catch (e) {
  //     Log.e(e);
  //     if (e is PlatformException) {
  //       if (e.code == 'sign_in_failed') {
  //         Log.w('Sign in failed: ${e.message}');
  //       } else {
  //         Log.w('Error: ${e.message}');
  //       }
  //     } else {
  //       Log.w('Error: ${e.toString()}');
  //     }
  //     btnController.stop();
  //   }
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    emailEditingController.dispose();
    passEditingController.dispose();
    super.dispose();
  }
}
