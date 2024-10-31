import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:import_mark/helper/hive_service.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../routes/app_pages.dart';
import '../controllers/onboard_controller.dart';

class OnboardView extends GetView<OnboardController> {
  const OnboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: ColorName.white,
        scrollPhysics: const BouncingScrollPhysics(),
        pages: [
          // PageViewModel(
          //   titleWidget: SmartAcademyLogo(height: 100.h,width: 90.w,),
          //   decoration: const PageDecoration(
          //       imageFlex: 1
          //   ),
          //   bodyWidget: Text(
          //     'Learn in-demand skills from nearby experts. Download Smart Academy and start your journey today!'.tr,
          //     textAlign: TextAlign.center,
          //     style: GoogleFonts.amaranth(
          //       textStyle: TextStyle(
          //         color: ColorName.black,
          //         fontSize: 18.sp,
          //         fontWeight: FontWeight.normal,
          //       ),
          //     ),
          //   ),
          //   image: Center(
          //     child: Image.asset(
          //       Assets.images.logoSvg,
          //       height: Get.height,
          //       width: Get.width,
          //     ),
          //   ),
          // ),
          PageViewModel(
            titleWidget: AppTextStyle(
              text: 'Courses',
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
            ),
            bodyWidget: Text(
              'Go beyond lectures. Learn with interactive courses and engaging lessons on Smart Academy'
                  .tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.amaranth(
                textStyle: TextStyle(
                  color: ColorName.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            image: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Image.asset(
                  Assets.images.logo.path,
                  height: Get.height,
                  width: Get.width,
                ),
              ),
            ),
          ),
          // PageViewModel(
          //   titleWidget: AppTextStyle(
          //     text: 'Mentors',
          //     fontSize: 22.sp,
          //     fontWeight: FontWeight.w600,
          //   ),
          //   bodyWidget: Text(
          //     'Get stuck? No problem. Your Smart Academy mentor is here to guide you every step of the way'.tr,
          //     textAlign: TextAlign.center,
          //     style: GoogleFonts.amaranth(
          //       textStyle: TextStyle(
          //         color: ColorName.black,
          //         fontSize: 18.sp,
          //         fontWeight: FontWeight.normal,
          //       ),
          //     ),
          //   ),
          //   image: Center(
          //     child: Padding(
          //       padding: const EdgeInsets.only(top: 10.0),
          //       child: Image.asset(
          //         Assets.images.onboard3.path,
          //         height: Get.height,
          //         width: Get.width,
          //       ),
          //     ),
          //   ),
          // ),
          // PageViewModel(
          //   titleWidget: AppTextStyle(
          //     text: 'Discover your Learning Adventure',
          //     fontSize: 22.sp,
          //     fontWeight: FontWeight.w600,
          //   ),
          //   bodyWidget: Text(
          //     'Mentor and student, united in exploration, find their paths by walking them together.'.tr,
          //     textAlign: TextAlign.center,
          //     style: GoogleFonts.amaranth(
          //       textStyle: TextStyle(
          //         color: ColorName.black,
          //         fontSize: 18.sp,
          //         fontWeight: FontWeight.normal,
          //       ),
          //     ),
          //   ),
          //   image: Center(
          //     child: Padding(
          //       padding: const EdgeInsets.only(top: 10.0),
          //       child: Image.asset(
          //         Assets.images.onboard4.path,
          //         height: Get.height,
          //         width: Get.width,
          //       ),
          //     ),
          //   ),
          // ),
          // PageViewModel(
          //   titleWidget: AppTextStyle(
          //     text: 'Stay Organized with Bookmarks',
          //     fontSize: 22.sp,
          //     fontWeight: FontWeight.w600,
          //   ),
          //   bodyWidget: Text(
          //     'Stay organized, stay focused. Bookmark your learning journey with Smart Academy.'.tr,
          //     textAlign: TextAlign.center,
          //     style: GoogleFonts.amaranth(
          //       textStyle: TextStyle(
          //         color: ColorName.black,
          //         fontSize: 18.sp,
          //         fontWeight: FontWeight.normal,
          //       ),
          //     ),
          //   ),
          //   image: Center(
          //     child: Padding(
          //       padding: const EdgeInsets.only(top: 10.0),
          //       child: Image.asset(
          //         Assets.images.onboard5.path,
          //         height: Get.height,
          //         width: Get.width,
          //       ),
          //     ),
          //   ),
          // ),
        ],
        onDone: () {
          HiveService.setOnBoardShowed(true);
          Get.toNamed(Routes.LOGIN);
        },
        onSkip: () {
          HiveService.setOnBoardShowed(true);
          Get.toNamed(Routes.LOGIN);
        },
        showSkipButton: true,
        skip: AppTextStyle(
          text: 'Skip',
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
          color: ColorName.primaryColor,
        ),
        next: const Icon(
          Icons.arrow_forward,
          color: ColorName.primaryColor,
        ),
        done: AppTextStyle(
          text: 'Done',
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
          color: ColorName.primaryColor,
        ),
        dotsDecorator: DotsDecorator(
          size: const Size.square(5),
          activeSize: const Size(20, 10),
          color: ColorName.gray410,
          activeColor: ColorName.primaryColor,
          spacing: const EdgeInsets.symmetric(horizontal: 3),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
