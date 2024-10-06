import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:import_mark/firebase_options.dart';
// import 'package:shopaholic_seller/app/modules/splash_screen/bindings/splash_screen_binding.dart';
// import 'package:shopaholic_seller/app/routes/app_pages.dart';
// import 'package:shopaholic_seller/global/log_printer.dart';
// import 'app/modules/auth/controllers/auth_controller.dart';
import 'app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/services/local_store_config.dart';
import 'app/services/notification_manager.dart';
import 'helper/language.dart';
import 'helper/helper_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///    Initialize Firebase
  if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp(
      name: 'import-mark',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  await _setupApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) => GetMaterialApp(
        textDirection: TextDirection.ltr,
        title: 'Shopaholic Vendor',
        debugShowCheckedModeBanner: false,

        ///  Routing Initialization
        initialRoute: AppPages.INITIAL,
        initialBinding: SplashScreenBinding(),
        getPages: AppPages.routes,

        ///  Language Initialization
        // translations: Languages(),
        // locale: HelperUtils.locateLanguage(),
        // fallbackLocale: HelperUtils.locateLanguage(),
      ),
      designSize: const Size(360, 800),
    );
  }
}

///  Initialization  Local Storage Hive, Firebase Notification
Future<void> _setupApp() async {
  await HiveService.initHive();
  // await HiveService.checkLoginStatus();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await NotificationManager().initialize();
  // String? firebaseToken = await FirebaseMessaging.instance.getToken();
  // if (firebaseToken != "" && firebaseToken!.isNotEmpty) {
  //   HiveService.deleteFirebaseToken();
  //   HiveService.setFirebaseToken(firebaseToken);
  //   HelperUtils.firebaseToken = (await HiveService.getFirebaseToken())!;
  // }
}
