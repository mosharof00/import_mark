// import 'dart:ui';
// import 'package:get/get.dart';
// import 'dart:core';
// import '../app/modules/home/controllers/home_controller.dart';
// import '../app/routes/app_pages.dart';
// import '../app/services/local_store_config.dart';
//
// class HelperUtils {
//   static Locale locateLanguage() {
//     return Locale(language(), language().toUpperCase());
//   }
//
//   static String language() {
//     return HiveService.getLanguage().split('_')[0] ?? 'en';
//   }
//
//   static navigateToOrder() {
//     Get.offAllNamed(Routes.MAINPAGE); // Navigate to Dashboard
//     Get.put(MainPageController());
//     Get.put(HomeController());
//     Get.toNamed(Routes.MY_ORDER);
//   }
//
//   static initializeController() async {
//     Get.put(MainPageController(), permanent: true);
//     Get.put(HomeController(), permanent: true);
//     await Future.delayed(const Duration(seconds: 3));
//   }
//
//   static deletePermanentController() {
//     Get.delete<HomeController>(force: true);
//     Get.delete<MainPageController>(force: true);
//   }
//
//   static String firebaseToken = ""; // Firebase token
//   static bool isLogin = false; // User Logged in or not
//   static String token = ""; // Api Token
//   static int userID = 0; // Api User ID
//   ///  Product Types
//   static String newArrivals = 'new_arrival';
//   static String flashSales = 'flash_sale';
//   static String specialOffers = 'special_offer';
//   static String trendingProducts = 'trending';
// }
