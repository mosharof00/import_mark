import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///    Initialize Firebase
  // if(Platform.isIOS){
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }
  // else{
  //   await Firebase.initializeApp(
  //     name:'Shopaholic-Vendor',
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }

  // await _setupApp();
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
        // initialBinding: SplashScreenBinding(),
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
